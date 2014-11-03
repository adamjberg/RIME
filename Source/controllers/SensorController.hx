package controllers;

import models.sensors.*;
import models.sensors.Accelerometer;
import models.sensors.Sensor;
import openfl.events.TimerEvent;
import openfl.utils.Timer;

class SensorController {

    private static var UPDATE_INTERVAL:Float = 0.2;

    private static var sensorClasses:Array<Class<Sensor>> =
    [
        Accelerometer,
        AmbientTemperature,
        Gravity,
        Humidity,
        Light,
        LinearAccelerometer,
        Magnetic,
        Orientation,
        Pressure,
        Proximity,
        Rotation
    ];

    public var sensors:Array<Sensor>;

    private var updateTimer:Timer;

    public function new()
    {
        sensors = new Array<Sensor>();
        fillWithSupportedSensors();
        updateTimer = new Timer(UPDATE_INTERVAL, 0);
        updateTimer.addEventListener(TimerEvent.TIMER, update);
        updateTimer.start();
    }

    private function fillWithSupportedSensors()
    {
        for(sensorClass in sensorClasses)
        {
            var sensor = Type.createInstance(sensorClass, []);
            if(sensor.isSupported())
            {
                sensor.enabled = true;
                sensors.push(sensor);
            }
        }
    }

    private function update(?e:TimerEvent)
    {
        for(sensor in sensors)
        {
            if(sensor.enabled)
            {
                sensor.update();
            }
        }
    }
}