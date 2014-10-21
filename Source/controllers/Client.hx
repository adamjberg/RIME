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
    private var sendTimer:Timer;
    private var message:OscMessage;

    private var sensors:Array<Sensor>;

    public function new(?serverInfo:ServerInfo, ?sensors:Array<Sensor>)
    {
        this.serverInfo = serverInfo;
        this.sensors = sensors;

        #if !neko
            socket = new UdpSocket();
            socket.create();
        #end

        message = new OscMessage("rime");
    }

    public function connect()
    {
        #if !neko
            socket.connect(serverInfo.ipAddress, serverInfo.portNumber);
        #end
        sendTimer = new Timer(1000, 0);
        sendTimer.addEventListener(TimerEvent.TIMER, timerHandler);
        //sendTimer.start();
    }

    public function disconnect()
    {
        #if !neko
            socket.close();
        #end
        sendTimer.stop();
        sendTimer.removeEventListener(TimerEvent.TIMER, timerHandler);
        sendTimer = null;
    }

    public function send(message:OscMessage)
    {
        #if !neko
            socket.send(message.getBytes());
        #end
        message.clear();
    }

    private function timerHandler(e:TimerEvent)
    {
        for(sensor in sensors)
        {
            if(sensor.enabled)
            {
                sensor.addToOscMessage(message);
            }
        }
        send(message);
    }
}