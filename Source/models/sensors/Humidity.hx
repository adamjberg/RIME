package models.sensors;

class Humidity extends Sensor {

    public function new()
    {
        super("Humidity", "hum", ["humidity"]);
    }

    override public function isSupported():Bool
    {
        return SensorExtension.isHumiditySupported();
    }

    override public function update()
    {
        values = SensorExtension.getHumidity();
        super.update();
    }
}