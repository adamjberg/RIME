package controllers;

import hxudp.UdpSocket;
import haxe.io.Bytes;
import haxe.io.BytesInput;

import haxe.ui.toolkit.core.PopupManager;

import models.commands.ViperCommand;
import models.sensors.Sensor;
import models.ServerInfo;
import msignal.Signal.Signal0;
import openfl.events.AccelerometerEvent;
import openfl.events.TimerEvent;
import openfl.sensors.Accelerometer;
import openfl.utils.Timer;
import osc.OscMessage;

class Client {

    private static inline var VIPER_ADDR_PATTERN:String = "/viper";
    private static inline var BUFF_SIZE:Int = 65535;
    private static inline var HEARTBEAT_DELAY_MS:Int = 5000;

    public var onConnected:Signal0 = new Signal0();
    public var onDisconnected:Signal0 = new Signal0();

    public var serverInfo:ServerInfo;
    private var socket:UdpSocket;

    private var heartbeatTimer:Timer;

    public function new()
    {
        heartbeatTimer = new Timer(HEARTBEAT_DELAY_MS);
        heartbeatTimer.addEventListener(TimerEvent.TIMER, checkConnectivity);
    }

    public function toggleConnectionStatus()
    {
        if(socket == null)
        {
            connect();
        }
        else
        {
            disconnect();
        }
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
            checkConnectivity();
        #end
    }

    public function disconnect()
    {
        serverInfo.connectionStatus = ServerInfo.DISCONNECTED;
        #if !neko
            socket.close();
            socket = null;
        #end
        onDisconnected.dispatch();
        heartbeatTimer.reset();
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

    private function checkConnectivity(?event:TimerEvent)
    {
        var command:ViperCommand = new ViperCommand(null,"connect");
        send(command.fillOscMessage());

        serverInfo.connectionStatus = ServerInfo.CONNECTING;
        var response:OscMessage = receive();

        // Make sure it's from viper
        if(response.addressPattern == VIPER_ADDR_PATTERN)
        {
            serverInfo.connectionStatus = ServerInfo.CONNECTED;
            onConnected.dispatch();
            heartbeatTimer.reset();
        }
        else
        {
            alertConnectionProblem();
            heartbeatTimer.start();
        }
    }

    private function alertConnectionProblem():Void
    {
        PopupManager.instance.showBusy("A problem with your connection was detected RIME will attempt to reconnect", 1000, "Connectivity Problem!");
    }
}