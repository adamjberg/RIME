package controllers;

import hxudp.UdpSocket;
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
        #if !neko
            socket.send(message.getBytes());
        #end
    }
}