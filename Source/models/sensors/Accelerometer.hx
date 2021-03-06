package models.sensors;

import org.haxe.extension.Sensors;

class Accelerometer extends Sensor {

    public static inline var NAME:String = "Accelerometer";

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
        super(NAME, "acc", ["X", "Y", "Z"]);
    }

    override public function isSupported():Bool
    {
        return Sensors.isAccelerometerSupported();
    }

    override public function update()
    {
        values = Sensors.getAccel();
        super.update();
    }
}