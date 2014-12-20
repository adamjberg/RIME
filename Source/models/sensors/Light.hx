package models.sensors;

import org.haxe.extension.Sensors;

class Light extends Sensor {

    public static inline var NAME:String = "Light";

    public function new()
    {
        super(NAME, "lig", ["light"]);
    }

    override public function isSupported():Bool
    {
        return Sensors.isLightSupported();
    }

    override public function update()
    {
        values[0] = Sensors.getLight();
        super.update();
    }
}