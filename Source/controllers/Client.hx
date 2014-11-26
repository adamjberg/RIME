package controllers;

import hxudp.UdpSocket;
import haxe.io.Bytes;
import haxe.io.BytesInput;

import models.sensors.Sensor;
import models.ServerInfo;
import openfl.events.AccelerometerEvent;
import openfl.events.TimerEvent;
import openfl.sensors.Accelerometer;
import openfl.utils.Timer;
import osc.OscMessage;

class Client {

    private var serverInfo:ServerInfo;
    private var socket:UdpSocket;

    public function new(serverInfo:ServerInfo)
    {
        this.serverInfo = serverInfo;

        #if !neko
            socket = new UdpSocket();
            socket.create();
        #end
    }

    public function connect()
    {
        #if !neko
            socket.connect(serverInfo.ipAddress, serverInfo.portNumber);
            send(new OscMessage());
        #end
    }

    public function disconnect()
    {
        #if !neko
            socket.close();
        #end
    }

    public function send(message:OscMessage)
    {
        if(message != null)
        {
            #if !neko
                socket.send(message.getBytes());
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
        trace("requested receive");

        // Allocate bytes to be populated by Viper's OSC message to RIME
        trace("server setNonBlocking true: " + socket.setNonBlocking(true));
        var b = Bytes.alloc(500);
        // Opens the socket to receive a message
        trace("server receive: " + socket.receive(b));
        trace("server receive dump:");

        // Saves bytes from receiving into a string and returns it to the code calling the receive function()
        var input = new BytesInput(b);
        var str = "";
        var byte = input.readByte();
        var char = String.fromCharCode(byte);
        var n = 0;
            var str = "";
            for (j in 0...409)
            {
                var byte = input.readByte();
                var char = String.fromCharCode(byte);
                str += (byte >= 30 && byte < 127 ? char : "");
            }
        trace(str);
        trace("server setNonBlocking false: " + socket.setNonBlocking(false));
        return str;
    }
    
    public function setTimeoutReceive(seconds:Int):Void
    {
        socket.setTimeoutReceive(seconds);
    }
}