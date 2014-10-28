package models.sensors;

class LinearAccelerometer extends Sensor {

    public var accelX(get, null):Float;
    function get_accelX():Float {
        return values[0];
    }

    public var accelY(get, null):Float;
    function get_accelY():Float {
        return values[1];
    }

    public var accelZ(get, null):Float;
    function get_accelZ():Float {
        return values[2];
    }

    public function new()
    {
        super("LinearAccelerometer", "lin", ["X", "Y", "Z"]);
    }

    override public function isSupported():Bool
    {
        return SensorExtension.isLinearAccelerometerSupported();
    }

    override public function update()
    {
        values = SensorExtension.getLnaccel();
        super.update();
    }
}