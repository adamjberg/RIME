package models.sensors;

class Gyroscope extends Sensor {

    public static inline var NAME:String = "Gyroscope";

    public var rotationX(get, null):Float;
    function get_rotationX():Float {
        return values[0];
    }

    public var rotationY(get, null):Float;
    function get_rotationY():Float {
        return values[1];
    }

    public var rotationZ(get, null):Float;
    function get_rotationZ():Float {
        return values[2];
    }

    public function new()
    {
        super(NAME, "gyr", ["X", "Y", "Z"]);
    }

    override public function isSupported():Bool
    {
        return SensorExtension.isGyroSupported();
    }

    override public function update()
    {
        values = SensorExtension.getGyro();
        super.update();
    }
}