package models.sensors;

class AmbientTemperature extends Sensor {

    public function new()
    {
        super("Ambient Temperature", "amt", ["temperature"]);
    }

    override public function isSupported():Bool
    {
        return SensorExtension.isAmbientTemperatureSupported();
    }

    override public function update()
    {
        values = SensorExtension.getAmtemp();
        super.update();
    }
}