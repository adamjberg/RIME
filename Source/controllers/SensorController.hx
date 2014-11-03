package controllers;

import models.sensors.*;
import filters.ChangeDetectFilter;
import filters.IdleStateFilter;
import models.sensors.Accelerometer;
import models.sensors.Sensor;
import msignal.Signal.Signal0;
import openfl.events.TimerEvent;
import openfl.utils.Timer;

class SensorController {

    public var onSensorsUpdated:Signal0 = new Signal0();

    private static var UPDATE_INTERVAL:Float = 16.6;

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

    public function getEnabledSensors():Array<Sensor>
    {
        return sensors.filter(
            function(sensor)
            {
                return sensor.enabled;
            }
        );
    }

    private function fillWithSupportedSensors()
    {
        for(sensorClass in sensorClasses)
        {
            var sensor = Type.createInstance(sensorClass, []);
            if(sensor.isSupported())
            {
                sensor.addFilterToAllValues(new IdleStateFilter());
                sensor.addFilterToAllValues(new ChangeDetectFilter());

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
        onSensorsUpdated.dispatch();
    }
}