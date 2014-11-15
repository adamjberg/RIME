package views.screens;

import controllers.ScreenManager;
import haxe.ui.toolkit.controls.Button;
import msignal.Signal.Signal0;
import openfl.events.MouseEvent;
import views.controls.FullWidthButton;
import views.screens.Screen;

class HomeScreen extends Screen {


    public var onConnectionSetupPressed:Signal0 = new Signal0();
    public var onSensorsPressed:Signal0 = new Signal0();
    public var onGesturesPressed:Signal0 = new Signal0();
    public var onPerformPressed:Signal0 = new Signal0();

    private var buttonStrings:Array<String> =
    [
        "Connection Setup",
        "Sensors",
        "Gestures",
        "Perform"
    ];
    private var buttonPressedSignals:Array<Signal0> = new Array<Signal0>();
    private var openScreenButtons:Array<Button> = new Array<Button>();

    public function new() {
        super();

        buttonPressedSignals.push(onConnectionSetupPressed);
        buttonPressedSignals.push(onSensorsPressed);
        buttonPressedSignals.push(onGesturesPressed);
        buttonPressedSignals.push(onPerformPressed);
    }

    override private function initialize()
    {
        super.initialize();

        for(i in 0...buttonStrings.length)
        {
            var button:FullWidthButton = new FullWidthButton(buttonStrings[i]);
            button.onClick = function(e)
                {
                    buttonPressedSignals[i].dispatch();
            }
            openScreenButtons.push(button);
            addChild(button);
        }
    }
}