package models.sensors;

import filters.Filter;
import msignal.Signal;

class Sensor {

    public var onUpdate:Signal1<Dynamic> = new Signal1<Dynamic>();

    public var name:String;
    public var id:String;
    public var values:Array<Float> = new Array<Float>();
    public var valueLabels:Array<String> = new Array<String>();
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

    public function update()
    {
        onUpdate.dispatch(values);
    }

    private function enable(){}

    private function disable(){}

}