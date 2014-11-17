package views;

import haxe.ui.toolkit.containers.HBox;
import haxe.ui.toolkit.containers.ExpandablePanel;
import haxe.ui.toolkit.controls.Text;
import haxe.ui.toolkit.events.UIEvent;
import haxe.ui.toolkit.style.Style;
import models.sensors.Sensor;
import openfl.filters.DropShadowFilter;

class SensorListItem extends ExpandablePanel {
    private var hBoxes:Array<HBox> = new Array<HBox>();
    private var valueLabels:Array<Text> = new Array<Text>();
    private var values:Array<Text> = new Array<Text>();
    private var sensor:Sensor;

    public function new(?sensor:Sensor)
    {
        super();

        startExpanded = false;

        this.style.backgroundColor = 0xFFFFFF;
        this.sensor = sensor;
        this.text = sensor.name;

        for(i in 0...sensor.valueLabels.length)
        {
            var valueLabel:Text = new Text();
            var value:Text = new Text();
            var hBox:HBox = new HBox();
            hBox.percentWidth = 100;

            hBoxes.push(hBox);

            valueLabel.text = sensor.valueLabels[i] + ":";
            hBox.addChild(valueLabel);
            valueLabels.push(valueLabel);

            value.text = Std.string(sensor.values[i]);
            hBox.addChild(value);
            values.push(value);

            addChild(hBox);
        }

        percentWidth = 100;
    }

    public function update()
    {
        for(i in 0...sensor.values.length)
        {
            var newValue:Float = sensor.values[i];
            newValue *= 100;
            values[i].text = Std.string(Math.round(newValue) / 100);
        }
    }
}