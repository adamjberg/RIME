package models.sensors;

class Pressure extends Sensor {

    public static inline var NAME:String = "Pressure";

    public function new()
    {
        super(NAME, "pre", ["pressure"]);
    }

    override public function isSupported():Bool
    {
        return SensorExtension.isPressureSupported();
    }

    override public function update()
    {
        values[0] = SensorExtension.getPressure();
        super.update();
    }
}