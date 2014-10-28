package models.sensors;

class Proximity extends Sensor {

    public function new()
    {
        super("Proximity", "pro", ["proximity"]);
    }

    override public function isSupported():Bool
    {
        return SensorExtension.isProximitySupported();
    }

    override public function update()
    {
        values = SensorExtension.getProximity();
        super.update();
    }
}