package models.sensors;

import org.haxe.extension.Sensors;

class Pressure extends Sensor {

    public static inline var NAME:String = "Pressure";

    public function new()
    {
        super(NAME, "pre", ["pressure"]);
    }

    override public function isSupported():Bool
    {
        return Sensors.isPressureSupported();
    }

    override public function update()
    {
        values[0] = Sensors.getPressure();
        super.update();
    }
}