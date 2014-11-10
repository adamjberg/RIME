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

        if(isValid() == false)
        {
            return null;
        }

        sendTimer = new Timer(intervalInMs, 0);
        sendTimer.start();
        sendTimer.addEventListener(TimerEvent.TIMER, requestSend);
    }

    override public function isValid():Bool
    {
        if(sensorData == null)
        {
            trace("sensorData is null");
            return false;
        }
        else if(isValueIndexValid() == false)
        {
            trace("value index: " + valueIndex + " is invalid for sensor: " + sensorData.getSensorName());
            return false;
        }
        return true;
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

    private function isValueIndexValid():Bool
    {
        if(valueIndex == null)
        {
            return false;
        }
        return valueIndex < sensorData.sensor.numValues;
    }

    private function requestSend(e:TimerEvent)
    {
        onRequestSend.dispatch(this);
    }
}