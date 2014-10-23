package models.sensors;

import filters.Filter;
import msignal.Signal;
import osc.OscMessage;

class Sensor {

    public var onUpdate:Signal0 = new Signal0();

    public var name:String;
    public var id:String;
    public var values:Array<Float> = [ 0, 0, 0, 0, 0 ];
    public var valueLabels:Array<String> = ["", "", "", "", ""];
    public var enabled(default, set):Bool;
    function set_enabled(newEnabled:Bool) {
        if(newEnabled == enabled)
        {
            return enabled;
        }
        
        if(isSupported())
        {
            newEnabled ? enable() : disable();
        }
        return enabled = newEnabled;
    }
    public var numValues:Int = 0;

    private var filterList:Array<Array<Filter>> = [
        new Array<Filter>(),
        new Array<Filter>(),
        new Array<Filter>(),
        new Array<Filter>(),
        new Array<Filter>(),
    ];

    private function new(?name:String, ?id:String, ?valueLabels:Array<String>)
    {
        this.name = name;
        this.id = id;
        this.numValues = valueLabels.length;
        this.valueLabels = valueLabels;
    }

    public function isSupported():Bool
    {
        return false;
    }

    public function addFilter(filter:Filter, index:Int)
    {
        if(index >= 0 && index < filterList.length)
        {
            filterList[index].push(filter);
        }
        else
        {
            trace("Filter at index " + index + " doesn't exist.");
        }
    }

    public function removeFilter(filter:Filter, index:Int)
    {
        if(index >= 0 && index < filterList.length)
        {
            filterList[index].remove(filter);
        }
        else
        {
            trace("Filter at index " + index + " doesn't exist.");
        }
    }

    public function removeAllFiltersForIndex(index:Int)
    {
        filterList[index] = new Array<Filter>();
    }

    public function removeAllFilters()
    {
        filterList = [
            new Array<Filter>(),
            new Array<Filter>(),
            new Array<Filter>(),
            new Array<Filter>(),
            new Array<Filter>(),
        ];
    }

    public function update()
    {
        updateFilters();
        onUpdate.dispatch();
    }

    private function updateFilters()
    {
        for(valueIndex in 0...filterList.length)
        {
            for(filterIndex in 0...filterList[valueIndex].length)
            {
                values[valueIndex] = filterList[valueIndex][filterIndex].update(values[valueIndex]);
            }
        }
    }

    private function enable(){}

    private function disable(){}

    public function addToOscMessage(oscMessage:OscMessage)
    {
        oscMessage.addString(id);
        for(i in 0...numValues)
        {
            oscMessage.addFloat(values[i]);
        }
    }

}