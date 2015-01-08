package models.sensors;

import org.haxe.extension.Sensors;

class AmbientTemperature extends Sensor {

    public static inline var NAME:String = "Ambient Temperature";

    public function new()
    {
        super(NAME, "amt", ["temperature"]);
    }

    override public function isSupported():Bool
    {
        return Sensors.isAmbientTemperatureSupported();
    }

    override public function update()
    {
        values[0] = Sensors.getAmtemp();
        super.update();
    }
}