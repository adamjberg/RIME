package models.sensors;

class Accelerometer extends Sensor {

    public var accelerationX(get, null):Float;
    function get_accelerationX():Float {
        return values[0];
    }

    public var accelerationY(get, null):Float;
    function get_accelerationY():Float {
        return values[1];
    }

    public var accelerationZ(get, null):Float;
    function get_accelerationZ():Float {
        return values[2];
    }

    public function new()
    {
        super("Accelerometer", "acc", ["X", "Y", "Z"]);
    }

    override public function isSupported():Bool
    {
        return SensorExtension.isAccelerometerSupported();
    }

    override public function update()
    {
        values = SensorExtension.getAccel();
        super.update();
    }
}