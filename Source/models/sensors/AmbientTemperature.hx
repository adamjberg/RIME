package models.sensors;

class AmbientTemperature extends Sensor {

    public static inline var NAME:String = "Ambient Temperature";

    public function new()
    {
        super(NAME, "amt", ["temperature"]);
    }

    override public function isSupported():Bool
    {
        return SensorExtension.isAmbientTemperatureSupported();
    }

    override public function update()
    {
        values[0] = SensorExtension.getAmtemp();
        super.update();
    }
}