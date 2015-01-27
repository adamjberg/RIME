package models.sensors;

import org.haxe.extension.Sensors;

class Microphone extends Sensor {

    public static inline var NAME:String = "Volume";

    public function new()
    {
        super(NAME, "pre", ["microphone"]);
    }

    override public function isSupported():Bool
    {
        return true;
    }

    override public function update()
    {
        values[0] = Sensors.soundMeter();
        
        super.update();
    }
}