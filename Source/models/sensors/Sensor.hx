package models.sensors;

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