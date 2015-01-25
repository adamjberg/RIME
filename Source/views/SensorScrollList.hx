package views;

import haxe.ui.toolkit.containers.VBox;
import haxe.ui.toolkit.containers.Accordion;
import haxe.ui.toolkit.containers.ListView;
import models.sensors.Sensor;
import openfl.events.TimerEvent;
import openfl.utils.Timer;
import views.SensorListItem;

class SensorScrollList extends ListView {

    private var updateTimer:Timer;

    private var sensors:Array<Sensor>;
    private var sensorListItems:Array<SensorListItem> = new Array<SensorListItem>();
    private var accordion:Accordion;
    private var vBox:VBox;

    public function new(?sensors:Array<Sensor>)
    {
        super();

        this.sensors = sensors;

        this.percentHeight = 100;
        this.percentWidth = 100;
        this.allowSelection = false;
        this.horizontalAlign = "center";

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