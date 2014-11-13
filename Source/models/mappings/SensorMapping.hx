package models.mappings;

import models.commands.ViperCommand;
import models.mappings.MappingParameter;
import models.sensors.data.SensorData;
import openfl.events.TimerEvent;
import openfl.utils.Timer;
import osc.OscMessage;

class SensorMapping extends Mapping {

    private var sensorData:SensorData;
    private var intervalInMs:Int;

    private var sendDataTimer:Timer;

    public function new(sensorData:SensorData, interval:Int)
    {
        super();
        this.sensorData = sensorData;
        this.intervalInMs = interval;

        sendDataTimer = new Timer(intervalInMs, 0);
        sendDataTimer.addEventListener(TimerEvent.TIMER, sendData);
        sendDataTimer.start();
    }

    override public function getOscMessage():OscMessage
    {
        var message:OscMessage = null;

        for(targetId in targetIds)
        {
            for(mappingParam in parameters)
            {
                var command:ViperCommand = new ViperCommand(targetId, mappingParam.method);
                command.addParam(mappingParam.name, mappingParam.getDesired(sensorData.values[0]));
                command.fillOscMessage(message);
                trace("adding " + mappingParam.name + " as: " + mappingParam.getDesired(sensorData.values[0]));
            }
        }

        return message;
    }

    private function sendData(e:TimerEvent)
    {
        trace("send");
        this.send();
    }
}