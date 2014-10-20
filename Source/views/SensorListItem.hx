package views;

import haxe.ui.toolkit.containers.HBox;
import haxe.ui.toolkit.controls.CheckBox;
import haxe.ui.toolkit.controls.Text;
import haxe.ui.toolkit.events.UIEvent;
import haxe.ui.toolkit.style.Style;
import models.sensors.Sensor;
import openfl.filters.DropShadowFilter;

class SensorListItem extends HBox {
    private var name:Text;
    private var valueLabels:Array<Text> = new Array<Text>();
    private var values:Array<Text> = new Array<Text>();
    private var enable:CheckBox;
    private var sensor:Sensor;

    public function new(?sensor:Sensor)
    {
        super();

        this.sensor = sensor;

        percentWidth = 100;
        percentHeight = 20;

        style.backgroundColor = 0xFFFFFF;
        style.padding = 20;

        name = new Text();
        name.text = sensor.name;
        name.percentWidth = 100;
        name.textAlign = "center";
        addChild(name);

        for(i in 0...sensor.numValues)
        {
            var value:Text = new Text();
            var valueLabel = new Text();
            value.text = Std.string(sensor.values[i]);
            valueLabel.text = sensor.valueLabels[i] + ":";
            addChild(valueLabel);
            addChild(value);
            values.push(value);
            valueLabels.push(valueLabel);
        }

        enable = new CheckBox();
        enable.verticalAlign = "center";
        enable.selected = sensor.enabled;
        addChild(enable);

        enable.addEventListener(UIEvent.CHANGE, enableChanged);

        sensor.onUpdate.add(sensorUpdated);
    }

    private function enableChanged(?event:UIEvent)
    {
        sensor.enabled = enable.selected;
    }

    private function sensorUpdated()
    {
        for(i in 0...sensor.numValues)
        {
            values[i].text = Std.string(sensor.values[i]);
        }
    }
}