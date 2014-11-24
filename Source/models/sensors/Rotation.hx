package models.sensors;

class Rotation extends Sensor {

    public static inline var NAME:String = "Rotation";

    public function new()
    {
        super(NAME, "rot", ["X", "Y", "Z"]);
    }

    override public function isSupported():Bool
    {
        return SensorExtension.isRotationSupported();
    }

    override public function update()
    {
        values = SensorExtension.getRotvect();
        super.update();
    }
}