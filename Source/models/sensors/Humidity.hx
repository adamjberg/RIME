package models.sensors;

class Humidity extends Sensor {

    public static inline var NAME:String = "Humidity";

    public function new()
    {
        super(NAME, "hum", ["humidity"]);
    }

    override public function isSupported():Bool
    {
        return SensorExtension.isHumiditySupported();
    }

    override public function update()
    {
        values[0] = SensorExtension.getHumidity();
        super.update();
    }
}