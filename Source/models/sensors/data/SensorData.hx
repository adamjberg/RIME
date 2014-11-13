package models.sensors.data;

import models.sensors.Sensor;
import msignal.Signal;

class SensorData {

    public var onUpdate:Signal1<Dynamic> = new Signal1<Dynamic>();

    public var values:Array<Float> = new Array<Float>();

    public var sensor:Sensor;

    public function new(sensor:Sensor)
    {
        this.sensor = sensor;
        sensor.onUpdate.add(update);
    }

    public function getSensorName():String
    {
        return sensor.name;
    }

    private function update(newValues:Array<Float>)
    {
        var hasChanged:Bool = false;
        for(i in 0...newValues.length)
        {
            if(values[i] != newValues[i])
            {
                hasChanged = true;
            }
        }
        if(hasChanged)
        {
            values = newValues.copy();
            onUpdate.dispatch(values);
        }
    }

}