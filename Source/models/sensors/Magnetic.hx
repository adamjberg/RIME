package models.sensors;

class Magnetic extends Sensor {

    public function new()
    {
        super("Magnetic", "mag", ["X", "Y", "Z"]);
    }

    override public function isSupported():Bool
    {
        return SensorExtension.isMagneticSupported();
    }

    override public function update()
    {
        values = SensorExtension.getMagField();
        super.update();
    }
}