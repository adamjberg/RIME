package models.sensors;

import org.haxe.extension.Sensors;

class Magnetic extends Sensor {

    public static inline var NAME:String = "Magnetic";

    public function new()
    {
        super(NAME, "mag", ["X", "Y", "Z"]);
    }

    override public function isSupported():Bool
    {
        return Sensors.isMagneticFieldSupported();
    }

    override public function update()
    {
        values = Sensors.getMagneticField();
        super.update();
    }
}