package views;

import haxe.ui.toolkit.containers.VBox;
import haxe.ui.toolkit.containers.ScrollView;
import models.sensors.Sensor;
import views.SensorListItem;

class SensorScrollList extends ScrollView {

    private var sensors:Array<Sensor>;
    private var vBox:VBox;

    public function new(?sensors:Array<Sensor>)
    {
        super();

        this.sensors = sensors;

        this.style.borderSize = 0;
        this.style.spacingY = 10;

        this.percentWidth = 95;
        this.horizontalAlign = "center";

        vBox = new VBox();
        vBox.percentWidth = 100;
        addChild(vBox);

        for(sensor in sensors)
        {
            vBox.addChild(new SensorListItem(sensor));
        }
    }
}