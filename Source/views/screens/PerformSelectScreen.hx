package views.screens;

import haxe.ui.toolkit.controls.Button;
import msignal.Signal.Signal0;
import views.controls.FullWidthButton;
import views.screens.Screen;

class PerformSelectScreen extends Screen {

    public var onOpenGesturePressed:Signal0 = new Signal0();

    private var buttonStrings:Array<String> =
    [
        "Gesture Recognition",
    ];
    private var buttonPressedSignals:Array<Signal0> = new Array<Signal0>();
    private var openScreenButtons:Array<Button> = new Array<Button>();

    public function new() {
        super();

        buttonPressedSignals.push(onOpenGesturePressed);
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