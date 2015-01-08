package models.sensors;

import org.haxe.extension.Sensors;

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
        return Sensors.isGyroSupported();
    }

    override public function update()
    {
        values = Sensors.getGyro();
        super.update();
    }
}