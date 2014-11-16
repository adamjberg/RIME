package views;

import haxe.ui.toolkit.containers.VBox;
import haxe.ui.toolkit.containers.Accordion;
import haxe.ui.toolkit.containers.ScrollView;
import models.sensors.Sensor;
import openfl.events.TimerEvent;
import openfl.utils.Timer;
import views.SensorListItem;

class SensorScrollList extends ScrollView {

    private var updateTimer:Timer;

    private var sensors:Array<Sensor>;
    private var sensorListItems:Array<SensorListItem> = new Array<SensorListItem>();
    private var accordion:Accordion;
    private var vBox:VBox;

    public function new(?sensors:Array<Sensor>)
    {
        super();

        this._scrollSensitivity = 1;

        this.sensors = sensors;

        this.style.borderSize = 0;

        this.percentHeight = 100;
        this.percentWidth = 95;
        this.horizontalAlign = "center";

        vBox = new VBox();
        vBox.percentWidth = 100;
        addChild(vBox);

        for(sensor in sensors)
        {
            var sensorListItem:SensorListItem = new SensorListItem(sensor);
            sensorListItems.push(sensorListItem);
            vBox.addChild(sensorListItem);
        }

        updateTimer = new Timer(1000, 0);
        updateTimer.addEventListener(TimerEvent.TIMER, updateSensorValues);
        updateTimer.start();
    }

    private function updateSensorValues(e)
    {
        for(sensorListItem in sensorListItems)
        {
            sensorListItem.update();
        }
    }
}