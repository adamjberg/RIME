package controllers;

import hxudp.UdpSocket;
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

    private var accelerometer:Accelerometer;
    private var accelerometerData:Array<Float> = [0, 0, 0];

    public function new(?serverInfo:ServerInfo)
    {
        this.serverInfo = serverInfo;
        socket = new UdpSocket();
        socket.create();
        message = new OscMessage("rime");
        if(Accelerometer.isSupported)
        {
            accelerometer = new Accelerometer();
            accelerometer.addEventListener(AccelerometerEvent.UPDATE, accelerometerUpdate);
        }
    }

    public function connect()
    {
        socket.connect(serverInfo.ipAddress, serverInfo.portNumber);
        sendTimer = new Timer(1000, 0);
        sendTimer.addEventListener(TimerEvent.TIMER, timerHandler);
        sendTimer.start();
    }

    public function disconnect()
    {
        socket.close();
        sendTimer.stop();
        sendTimer.removeEventListener(TimerEvent.TIMER, timerHandler);
        sendTimer = null;
    }

    public function send()
    {
        socket.send(message.getBytes());
        message.clear();
    }

    private function timerHandler(e:TimerEvent)
    {
        message.addString("acc");
        message.addFloat(accelerometerData[0]);
        message.addFloat(accelerometerData[1]);
        message.addFloat(accelerometerData[2]);
        send();
    }

    private function accelerometerUpdate(event:AccelerometerEvent)
    {
        accelerometerData[0] = event.accelerationX;
        accelerometerData[1] = event.accelerationY;
        accelerometerData[2] = event.accelerationZ;
    }
}