package models.sensors;

import org.haxe.extension.Sensors;

class Rotation extends Sensor {

    public static inline var NAME:String = "Rotation";

    public function new()
    {
        super(NAME, "rot", ["X", "Y", "Z"]);
    }

    override public function isSupported():Bool
    {
        return Sensors.isRotationSupported();
    }

    override public function update()
    {
        values = Sensors.getRotvect();
        super.update();
    }
}