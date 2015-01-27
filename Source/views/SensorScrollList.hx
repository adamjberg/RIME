package views;

import views.controls.ListView;
import models.sensors.Sensor;
import openfl.events.TimerEvent;
import openfl.utils.Timer;

class SensorScrollList extends ListView {

    private var updateTimer:Timer;
    private var sensors:Array<Sensor>;

    public function new(?sensors:Array<Sensor>)
    {
        super();

        this.sensors = sensors;

        this.allowSelection = false;

        for(sensor in sensors)
        {
            dataSource.add(
            {
                text: sensor.name,
                subtext: sensor.getValuesAsString()
            });
        }

        updateTimer = new Timer(250, 0);
        updateTimer.addEventListener(TimerEvent.TIMER, updateSensorValues);
    }

    public function startUpdate()
    {
        updateTimer.start();
    }

    public function stopUpdate()
    {
        updateTimer.reset();
    }

    private function updateSensorValues(e)
    {
        var pos:Int = 0;
        if (dataSource.moveFirst()) {
            do {
                var sensor:Sensor = sensors[pos++];
                var data:Dynamic = dataSource.get();
                data.subtext = sensor.getValuesAsString();
            } while (dataSource.moveNext()); 
        }
        syncUI();
    }
}