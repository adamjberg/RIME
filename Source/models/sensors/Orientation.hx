package models.sensors;

class Orientation extends Sensor {

    public static inline var NAME:String = "Orientation";

    public var orientX(get, null):Float;
    function get_orientX():Float {
        return values[0];
    }

    public var orientY(get, null):Float;
    function get_orientY():Float {
        return values[1];
    }

    public var orientZ(get, null):Float;
    function get_orientZ():Float {
        return values[2];
    }

    public function new()
    {
        super(NAME, "ori", ["X", "Y", "Z"]);
    }

    override public function isSupported():Bool
    {
        return SensorExtension.isOrientationSupported();
    }

    override public function update()
    {
        values = SensorExtension.getOrient();
        super.update();
    }
}