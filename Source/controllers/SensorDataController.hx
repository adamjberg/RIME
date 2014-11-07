package controllers;

import controllers.SensorController;
import filters.*;
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
                new ChangeDetectFilter(),
            ];
            defaultFilteredSensorDatas.push(new FilteredSensorData(sensor, defaultFilters));
        }
    }

    
}