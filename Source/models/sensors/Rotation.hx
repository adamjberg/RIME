package models.sensors;

class Rotation extends Sensor {

    public function new()
    {
        super("Rotation", "rot", ["X", "Y", "Z"]);
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