package controllers;

import controllers.SensorController;
import filters.*;
import models.sensors.data.SensorData;
import models.sensors.Sensor;
import models.sensors.data.FilteredSensorData;
import models.sensors.data.RawSensorData;

class SensorDataController {
    public var rawSensorDatas:Array<RawSensorData> = new Array<RawSensorData>();
    public var defaultFilteredSensorDatas:Array<FilteredSensorData> = new Array<FilteredSensorData>();

    private var sensors:Array<Sensor>;

    public function new(sensors:Array<Sensor>)
    {
        this.sensors = sensors;

        var defaultFilters:Array<Filter>;
        for(sensor in sensors)
        {
            rawSensorDatas.push(new RawSensorData(sensor));

            defaultFilters = 
            [
                new IdleStateFilter(),
                new DirectionalEquivalenceFilter(),
                new ChangeDetectFilter(),
            ];
            defaultFilteredSensorDatas.push(new FilteredSensorData(sensor, defaultFilters));
        }
    }

    public function getFilteredWithName(sensorName:String):FilteredSensorData
    {
        for(sensorData in defaultFilteredSensorDatas)
        {
            if(sensorData.getSensorName() == sensorName)
            {
                return sensorData;
            }
        }
        return null;
    }

    public function getRawWithName(sensorName:String):SensorData
    {
        for(sensorData in rawSensorDatas)
        {
            if(sensorData.getSensorName() == sensorName)
            {
                trace("Am I returning sensor data?"); 
                return sensorData;
            }
        }
        trace("Or am I returning null from this raw sensor data object?"); 
        return null;
    }

    public function getFiltered():Array<FilteredSensorData>
    {
        return defaultFilteredSensorDatas;
    }
    
}