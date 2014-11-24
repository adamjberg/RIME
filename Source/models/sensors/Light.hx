package models.sensors;

class Light extends Sensor {

    public static inline var NAME:String = "Light";

    public function new()
    {
        super(NAME, "lig", ["light"]);
    }

    override public function isSupported():Bool
    {
        return SensorExtension.isLightSupported();
    }

    override public function update()
    {
        values[0] = SensorExtension.getLight();
        super.update();
    }
}