package views;

import haxe.ui.toolkit.containers.HBox;
import haxe.ui.toolkit.controls.CheckBox;
import haxe.ui.toolkit.controls.Text;
import haxe.ui.toolkit.style.Style;
import openfl.filters.DropShadowFilter;

class SensorListItem extends HBox {
    private var name:Text;
    private var enable:CheckBox;

    public function new()
    {
        super();

        percentWidth = 100;

        name = new Text();
        name.text = "Sensor";
        name.percentWidth = 100;
        name.textAlign = "center";
        addChild(name);

        enable = new CheckBox();
        enable.verticalAlign = "center";
        addChild(enable);
    }
}