package views.screens;

import controllers.PerformanceController;
import haxe.ui.toolkit.containers.Grid;
import haxe.ui.toolkit.containers.HBox;
import haxe.ui.toolkit.containers.ListView;
import haxe.ui.toolkit.containers.VBox;
import haxe.ui.toolkit.controls.Button;
import haxe.ui.toolkit.data.ArrayDataSource;
import haxe.ui.toolkit.events.UIEvent;
import models.Performance;
import models.Preset;
import views.controls.FullWidthButton;

class PerformanceScreen extends Screen {

    private var grid:Grid;
    private var performance:Performance;
    private var rows:Int = 3;
    private var columns:Int = 2;
    private var hBox:HBox;
    private var columnVBoxes:Array<VBox>;

    public function new(?performance:Performance)
    {
        super();

        this.performance = performance;

        hBox = new HBox();
        hBox.percentWidth = 100;
        hBox.percentHeight = 100;
        addChild(hBox);

        columnVBoxes = new Array<VBox>();
        for(i in 0...columns)
        {
            var vBox:VBox = new VBox();
            vBox.percentWidth = 100 / columns;
            vBox.percentHeight = 100;
            columnVBoxes.push(vBox);
            hBox.addChild(vBox);
        }

        var numButtons:Int = rows * columns;
        var presets:Array<Preset> = performance.presets;
        for(buttonIndex in 0...numButtons)
        {
            if(buttonIndex >= presets.length)
            {
                break;
            }
            var preset:Preset = presets[buttonIndex];
            var button:Button = new Button();
            button.text = preset.name;
            button.percentWidth = 100;
            button.percentHeight = 100 / rows;
            button.toggle = true;
            columnVBoxes[buttonIndex % columns].addChild(button);
        }
    }
}