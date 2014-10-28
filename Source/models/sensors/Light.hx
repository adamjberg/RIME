package models.sensors;

class Light extends Sensor {

    public function new()
    {
        super("Light", "lig", ["light"]);
    }

    override public function isSupported():Bool
    {
        return SensorExtension.isLightSupported();
    }

    override public function update()
    {
        values = SensorExtension.getLight();
        super.update();
    }
}