package views;

import haxe.ui.toolkit.containers.ScrollView;
import models.sensors.Sensor;
import views.SensorListItem;

class SensorScrollList extends ScrollView {

    private var sensors:Array<Sensor>;

    public function new(?sensors:Array<Sensor>)
    {
        super();

        this.sensors = sensors;

        this.style.borderSize = 0;
        this.style.spacingY = 10;

        this.percentWidth = 95;
        this.percentHeight = 100;
        this.horizontalAlign = "center";

        for(sensor in sensors)
        {
            addChild(new SensorListItem(sensor));
        }
    }
}