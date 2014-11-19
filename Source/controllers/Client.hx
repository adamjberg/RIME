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

    public function receive(message:OscMessage):String
    {
        trace("requested receive");

        var b = Bytes.alloc(2000);
        trace("server receive: " + socket.receive(b));
        trace("server receive dump:");
        var input = new BytesInput(b);
        var str = "";
        var byte = input.readByte();
        var char = String.fromCharCode(byte);
        var n = 0;
            var str = "";
            for (j in 0...500)
            {
                var byte = input.readByte();
                var char = String.fromCharCode(byte);
                str += (byte >= 30 && byte < 127 ? char : "");
            }
        trace(str);
        return str;
    }
}