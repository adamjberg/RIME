package models.sensors;

class Magnetic extends Sensor {

    public static inline var NAME:String = "Magnetic";

    public function new()
    {
        super(NAME, "mag", ["X", "Y", "Z"]);
    }

    override public function isSupported():Bool
    {
        return SensorExtension.isMagneticSupported();
    }

    override public function update()
    {
        values = SensorExtension.getMagneticField();
        super.update();
    }
}