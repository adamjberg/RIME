package models.sensors;

class Pressure extends Sensor {

    public function new()
    {
        super("Pressure", "pre", ["pressure"]);
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