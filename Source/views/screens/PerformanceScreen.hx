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
import msignal.Signal.Signal2;
import views.controls.FullWidthButton;

class PerformanceScreen extends Screen {

    public var onPresetStateChanged:Signal2<Preset,Bool> = new Signal2<Preset,Bool>();

    private var grid:Grid;
    private var performance:Performance;
    private var rows:Int = 3;
    private var columns:Int = 2;
    private var hBox:HBox;
    private var columnVBoxes:Array<VBox>;

    public function new()
    {
        super();

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
    }

    public function setPerformance(performance:Performance)
    {
        // If this performance has already been loaded there's no work to do
        if(performance == this.performance)
        {
            return;
        }
        this.performance = performance;

        for(vBox in columnVBoxes)
        {
            vBox.removeAllChildren();
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
            button.addEventListener(UIEvent.CHANGE, function(e:UIEvent){
                onPresetStateChanged.dispatch(preset, button.selected);
            });
            columnVBoxes[buttonIndex % columns].addChild(button);
        }
    }
}