package models.sensors;

class Proximity extends Sensor {

    public static inline var NAME:String = "Proximity";

    public function new()
    {
        super(NAME, "pro", ["proximity"]);
    }

    override public function isSupported():Bool
    {
        return SensorExtension.isProximitySupported();
    }

    override public function update()
    {
        values[0] = SensorExtension.getProximity();
        super.update();
    }
}