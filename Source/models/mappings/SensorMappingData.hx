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
    public var targetFields:Array<String>;
    public var maxDesireds:Array<Float>;
    public var minDesireds:Array<Float>;
    public var absoluteValue:Bool;
    public var magnitude:Bool;

    private var sendTimer:Timer;

    public function new(sensorData:SensorData, intervalInMs:Int,
            valueIndex:Int, targetFields:Array<String>,
            minDesireds:Array<Float>, maxDesireds:Array<Float>,
            absoluteValue:Bool, magnitude:Bool
    )
    {
        super();

        this.sensorData = sensorData;
        this.valueIndex = valueIndex;
        this.method = "update";
        this.targetFields = targetFields;
        this.minDesireds = minDesireds;
        this.maxDesireds = maxDesireds;
            
        this.absoluteValue = absoluteValue;
        this.magnitude = magnitude;

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
        else if(targetFields == null)
        {
            trace("no target fields specified");
            return false;
        }
        else if(minDesireds == null)
        {
            trace("no min desireds specified");
            return false;
        }
        else if(maxDesireds == null)
        {
            trace("no max desireds specified");
            return false;
        }
        return true;
    }

    override public function getViperCommands():Array<ViperCommand>
    {
        clearViperCommands();
        var command:ViperCommand = new ViperCommand();
        command.method = method;
        for(i in 0...targetFields.length)
        {
            command.addParam(targetFields[i], getData(i));
        }
        addViperCommand(command);
        return super.getViperCommands();
    }

    public function getData(index:Int):Float
    {
        var minValue:Float = sensorData.sensor.minValues[valueIndex];
        var maxValue:Float = sensorData.sensor.maxValues[valueIndex];
        var valToUse = sensorData.values[valueIndex];
        if(magnitude == true)
        {
            valToUse = sensorData.getMagnitude();
            minValue = 0;
            maxValue = 0;

            for(maxVal in sensorData.sensor.maxValues)
            {
                maxValue += Math.pow(maxVal, 2);
            }
            maxValue = Math.sqrt(maxValue);
        }
        else if(absoluteValue == true)
        {
            valToUse = Math.abs(valToUse);
            minValue = 0;
        }
        return ((valToUse - minValue) / (maxValue - minValue)) * (maxDesireds[index] - minDesireds[index]) + minDesireds[index];
    }

    private function isValueIndexValid():Bool
    {
        return valueIndex < sensorData.sensor.numValues;
    }

    private function requestSend(e:TimerEvent)
    {
        onRequestSend.dispatch(this);
    }
}