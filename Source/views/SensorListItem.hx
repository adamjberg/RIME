package views;

import haxe.ui.toolkit.containers.HBox;
import haxe.ui.toolkit.controls.Text;
import haxe.ui.toolkit.events.UIEvent;
import haxe.ui.toolkit.style.Style;
import models.sensors.Sensor;
import openfl.filters.DropShadowFilter;

class SensorListItem extends HBox {
    private static var ENABLED_BG_COLOR:Int = 0x00FF00;
    private static var DISABLED_BG_COLOR:Int = 0xFF0000;

    private var name:Text;
    private var sensor:Sensor;

    public function new(?sensor:Sensor)
    {
        super();

        this.sensor = sensor;

        percentWidth = 100;

        style.backgroundColor = 0xFFFFFF;
        style.padding = 20;

        name = new Text();
        name.text = sensor.name;
        name.percentWidth = 100;
        name.textAlign = "center";
        addChild(name);

        onClick = clicked;
        enableChanged();
    }

    private function clicked(e)
    {
        sensor.enabled = !sensor.enabled;
        enableChanged();
    }

    private function enableChanged()
    {
        if(sensor.enabled)
        {
            style.backgroundColor = ENABLED_BG_COLOR;
        }
        else
        {
           style.backgroundColor = DISABLED_BG_COLOR;
        }
    }
}