package models.sensors.data;

import filters.Filter;
import models.sensors.data.SensorData;
import models.sensors.Sensor;

class FilteredSensorData extends SensorData {

    private var filters:Array<Filter> = new Array<Filter>();

    public function new(sensor:Sensor, filters:Array<Filter>)
    {
        this.filters = filters;
        super(sensor);
    }

    override private function update(newValues:Array<Float>)
    {
        var filteredNewValues:Array<Float> = newValues.copy();
        for(filter in filters)
        {
            filteredNewValues = filter.update(filteredNewValues);
        }
        super.update(filteredNewValues);
    }

}