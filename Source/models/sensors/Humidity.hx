package models.sensors;

import org.haxe.extension.Sensors;

class Humidity extends Sensor {

    public static inline var NAME:String = "Humidity";

    public function new()
    {
        super(NAME, "hum", ["humidity"]);
    }

    override public function isSupported():Bool
    {
        return Sensors.isHumiditySupported();
    }

    override public function update()
    {
        values[0] = Sensors.getHumidity();
        super.update();
    }
}