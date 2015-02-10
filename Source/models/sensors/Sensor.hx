package models.sensors;

import org.haxe.extension.Sensors;

import filters.Filter;
import msignal.Signal;

class Sensor {

    public var onUpdate:Signal1<Dynamic> = new Signal1<Dynamic>();

    public var name:String;
    public var id:String;
    public var values:Array<Float> = new Array<Float>();
    public var maxValues:Array<Float> = [
        Math.NEGATIVE_INFINITY,
        Math.NEGATIVE_INFINITY,
        Math.NEGATIVE_INFINITY,
        Math.NEGATIVE_INFINITY,
        Math.NEGATIVE_INFINITY
    ];
    public var minValues:Array<Float> = [
        Math.POSITIVE_INFINITY,
        Math.POSITIVE_INFINITY,
        Math.POSITIVE_INFINITY,
        Math.POSITIVE_INFINITY,
        Math.POSITIVE_INFINITY
    ];
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

    public function getMaxMagnitude(components:Array<Int>):Float
    {
        var mag:Float = 0;
        for(component in components)
        {
            mag += Math.pow(maxValues[component], 2);
        }
        mag = Math.sqrt(mag);
        return mag;
    }

    public function update()
    {
        for(i in 0...values.length)
        {
            if(values[i] > maxValues[i])
            {
                maxValues[i] = values[i];
            }
            if(values[i] < minValues[i])
            {
                minValues[i] = values[i];
            }
        }
        onUpdate.dispatch(values);
    }

    public function getValuesAsString():String
    {
        var outputString:String = "";
        var roundedVal:Float = 0;
        for(i in 0...values.length)
        {
            outputString += valueLabels[i] + ": ";

            roundedVal = Math.round(values[i] * 100) / 100;
            outputString += Std.string(roundedVal) + " ";
        }
        return outputString;
    }

    private function enable(){}

    private function disable(){}

}