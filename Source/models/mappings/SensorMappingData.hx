package models.mappings;

import models.commands.ViperCommand;
import models.mappings.MappingData;
import models.sensors.data.SensorData;
import openfl.events.TimerEvent;
import openfl.utils.Timer;
import osc.OscMessage;

class SensorMappingData extends MappingData {

    public var sensorData:SensorData;
    public var valueIndex:Int;
    public var method:String;
    public var targetField:String;
    public var maxDesired:Float;
    public var minDesired:Float;
    public var maxPossible:Float;

    private var sendTimer:Timer;

    public function new(sensorData:SensorData, intervalInMs:Int, valueIndex:Int, method:String, targetField:String, minDesired:Float, maxDesired:Float)
    {
        super();

        this.sensorData = sensorData;
        this.valueIndex = valueIndex;
        this.method = method;
        this.targetField = targetField;
        this.minDesired = minDesired;
        this.maxDesired = maxDesired;

        // TODO: Fix this to grab from sensor data
        this.maxPossible = 1;

        sendTimer = new Timer(intervalInMs, 0);
        sendTimer.start();
        sendTimer.addEventListener(TimerEvent.TIMER, requestSend);
    }

    override public function fillViperCommand(viperCommand:ViperCommand)
    {
        viperCommand.method = method;
        viperCommand.addParam(targetField, getData());
    }

    public function getData():Float
    {
        return (sensorData.values[valueIndex] / maxPossible) * (maxDesired - minDesired) + minDesired;
    }

    private function requestSend(e:TimerEvent)
    {
        onRequestSend.dispatch(this);
    }
}