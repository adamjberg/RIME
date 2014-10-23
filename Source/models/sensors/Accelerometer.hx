package models.sensors;

import openfl.events.AccelerometerEvent;

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

    private var acc:openfl.sensors.Accelerometer;

    public function new()
    {
        super("Accelerometer", "acc", ["X", "Y", "Z"]);
        acc = new openfl.sensors.Accelerometer();
    }

    override private function enable()
    {
        acc.addEventListener(AccelerometerEvent.UPDATE, updateAccel);
    }

    override private function disable()
    {
        acc.removeEventListener(AccelerometerEvent.UPDATE, updateAccel);
    }

    override public function isSupported():Bool
    {
        return openfl.sensors.Accelerometer.isSupported;
    }

    private function updateAccel(?event:AccelerometerEvent)
    {
        values[0] = event.accelerationX;
        values[1] = event.accelerationY;
        values[2] = event.accelerationZ;
        super.update();
    }
}