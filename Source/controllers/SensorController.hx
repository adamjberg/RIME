package controllers;

import models.sensors.LinearAccelerometer;
import models.sensors.Sensor;

class SensorController {

    private static var sensorClasses:Array<Class<Sensor>> =
    [
        LinearAccelerometer,
    ];

    public var sensors:Array<Sensor>;

    public function new()
    {
        sensors = new Array<Sensor>();
        fillWithSupportedSensors();
    }

    private function fillWithSupportedSensors()
    {
        for(sensorClass in sensorClasses)
        {
            var sensor = Type.createInstance(sensorClass, []);
            if(sensor.isSupported())
            {
                sensors.push(sensor);
            }
        }
    }
}