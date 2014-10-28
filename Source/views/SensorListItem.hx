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
    private var valueLabels:Array<Text> = new Array<Text>();
    private var values:Array<Text> = new Array<Text>();
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

        for(i in 0...sensor.numValues)
        {
            var value:Text = new Text();
            var valueLabel = new Text();
            value.text = Std.string(Math.round(sensor.values[i]));
            valueLabel.text = sensor.valueLabels[i] + ":";
            addChild(valueLabel);
            addChild(value);
            values.push(value);
            valueLabels.push(valueLabel);
        }

        sensor.onUpdate.add(sensorUpdated);
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

    private function sensorUpdated()
    {
        if(sensor.values == null)
        {
            trace("Values is null");
            return;
        }
        for(i in 0...sensor.numValues)
        {
            values[i].text = Std.string(Math.round(sensor.values[i]));
        }
    }
}