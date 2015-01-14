package controllers;

import hxudp.UdpSocket;
import haxe.io.Bytes;
import haxe.io.BytesInput;

import haxe.ui.toolkit.core.PopupManager;

import models.sensors.Sensor;
import models.ServerInfo;
import openfl.events.AccelerometerEvent;
import openfl.events.TimerEvent;
import openfl.sensors.Accelerometer;
import openfl.utils.Timer;
import osc.OscMessage;

class Client {

    public var connected:Bool = false;

    private var serverInfo:ServerInfo;
    private var socket:UdpSocket;

    public function new(serverInfo:ServerInfo)
    {
        this.serverInfo = serverInfo;
    }

    public function connect()
    {
        if(socket != null)
        {
            trace("connecting when socket already exists");
            socket.close();
        }
        #if !neko
            socket = new UdpSocket();
            if(socket.create() == false)
            {
                alertConnectionProblem();
            }
            socket.connect(serverInfo.ipAddress, serverInfo.portNumber);
        #end
        connected = true;
    }

    public function disconnect()
    {
        #if !neko
            socket.close();
            socket = null;
        #end
        connected = false;
    }

    public function send(message:OscMessage)
    {
        if(message != null)
        {
            #if !neko
                var bytesSent:Int = socket.send(message.getBytes());
                if(bytesSent == 0)
                {
                    trace("No bytes were sent, this may be an issue");
                }
                else if(bytesSent == -1)
                {
                    alertConnectionProblem();
                }
            #end 
        }
        else
        {
            trace("Trying to send null message");
        }
        
    }

    // Command to receive the string of file names from Viper
    // Referenced hxudp/test/UdpTest.hx
    public function receive(message:OscMessage):String
    {
        socket.setTimeoutReceive(1);

        // Allocate bytes to be populated by Viper's OSC message to RIME
        var b = Bytes.alloc(1000);
        // Opens the socket to receive a message
        trace("server receive: " + socket.receive(b));

        // Saves bytes from receiving into a string and returns it to the code calling the receive function()
        var input = new BytesInput(b);
        var str = "";
        var byte = input.readByte();
        var char = String.fromCharCode(byte);
        var n = 0;
            var str = "";
            for (j in 0...999)
            {
                var byte = input.readByte();
                var char = String.fromCharCode(byte);
                str += (byte >= 30 && byte < 127 ? char : "");
            }
        return str;
    }

    private function alertConnectionProblem():Void
    {
        PopupManager.instance.showSimple("A connection could not be made", "Connectivity Problem!");
    }
}