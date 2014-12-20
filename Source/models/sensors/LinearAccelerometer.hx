package models.sensors;

import org.haxe.extension.Sensors;

class LinearAccelerometer extends Sensor {

    public static inline var NAME:String = "Linear Accelerometer";

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
        super(NAME, "lin", ["X", "Y", "Z"]);
    }

    override public function isSupported():Bool
    {
        return Sensors.isLinearAccelerometerSupported();
    }

    override public function update()
    {
        values = Sensors.getLnaccel();
        super.update();
    }
}