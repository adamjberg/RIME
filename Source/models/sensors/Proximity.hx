package models.sensors;

import org.haxe.extension.Sensors;

class Proximity extends Sensor {

    public static inline var NAME:String = "Proximity";

    public function new()
    {
        super(NAME, "pro", ["proximity"]);
    }

    override public function isSupported():Bool
    {
        return Sensors.isProximitySupported();
    }

    override public function update()
    {
        values[0] = Sensors.getProximity();
        super.update();
    }
}