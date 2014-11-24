package models.sensors;

class Gravity extends Sensor {

    public static inline var NAME:String = "Gravity";

    public var gravityX(get, null):Float;
    function get_gravityX():Float {
        return values[0];
    }

    public var gravityY(get, null):Float;
    function get_gravityY():Float {
        return values[1];
    }

    public var gravityZ(get, null):Float;
    function get_gravityZ():Float {
        return values[2];
    }

    public function new()
    {
        super(NAME, "gra", ["X", "Y", "Z"]);
    }

    override public function isSupported():Bool
    {
        return SensorExtension.isGravitySupported();
    }

    override public function update()
    {
        values = SensorExtension.getGravity();
        super.update();
    }
}