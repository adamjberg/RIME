package controllers;

import hxudp.UdpSocket;
import haxe.io.Bytes;
import haxe.io.BytesInput;

import haxe.ui.toolkit.core.PopupManager;

import models.commands.ViperCommand;
import models.sensors.Sensor;
import models.ServerInfo;
import openfl.events.AccelerometerEvent;
import openfl.events.TimerEvent;
import openfl.sensors.Accelerometer;
import openfl.utils.Timer;
import osc.OscMessage;

class Client {

    private static inline var VIPER_ADDR_PATTERN:String = "/viper";
    private static inline var BUFF_SIZE:Int = 65535;

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

            var command:ViperCommand = new ViperCommand(null,"connect");
            send(command.fillOscMessage());
            var response:OscMessage = receive();

            // Make sure it's from viper
            if(response.addressPattern == VIPER_ADDR_PATTERN)
            {
                connected = true;
            }
            else
            {
                alertConnectionProblem();
            }
        #end
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
        if(socket == null)
        {
            trace("Socket is null");
            return;
        }
        if(message != null)
        {
            #if !neko
                var bytesSent:Int = socket.send(message.getBytes());
                trace("bytes sent: " + bytesSent);
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

    public function receive():OscMessage
    {
        if(socket == null)
        {
            return null;
        }

        socket.setTimeoutReceive(1);

        var b = Bytes.alloc(BUFF_SIZE);
        var ret:Int = socket.receive(b);
        var responseMessage:OscMessage = OscMessage.fromBytes(b);

        return responseMessage;
    }

    private function alertConnectionProblem():Void
    {
        PopupManager.instance.showSimple("A connection could not be made", "Connectivity Problem!");
    }
}