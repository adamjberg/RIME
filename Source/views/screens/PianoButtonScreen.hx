package views.screens;

import controllers.Client;
import haxe.ui.toolkit.containers.Container;
import haxe.ui.toolkit.containers.Grid;
import haxe.ui.toolkit.containers.HBox;
import haxe.ui.toolkit.containers.VBox;
import openfl.events.MouseEvent;
import osc.OscMessage;
import views.PianoButton;

class PianoButtonScreen extends Container {

    private static var NUM_BUTTONS:Int = 8;

    private var client:Client;

    private var vBox1:VBox;
    private var vBox2:VBox;
    private var hBox:HBox;
    public var pianoButtons:Array<PianoButton> = new Array<PianoButton>();

    public function new(?client:Client)
    {
        super();

        this.client = client;

        this.percentWidth = 100;
        this.percentHeight = 100;

        vBox1 = new VBox();
        vBox2 = new VBox();
        hBox = new HBox();

        vBox1.percentWidth = 50;
        vBox1.percentHeight = 100;
        vBox2.percentWidth = 50;
        vBox2.percentHeight = 100;
        hBox.percentWidth = 100;
        hBox.percentHeight = 100;

        addChild(hBox);

        hBox.addChild(vBox1);
        hBox.addChild(vBox2);

        for(i in 0...NUM_BUTTONS)
        {
            var pianoButton:PianoButton = new PianoButton();
            pianoButton.addEventListener(MouseEvent.MOUSE_DOWN, pianoButtonDown);
            pianoButton.addEventListener(MouseEvent.MOUSE_UP, pianoButtonUp);

            pianoButton.percentWidth = 100;
            pianoButton.percentHeight = 100 / NUM_BUTTONS * 2;
            if(i % 2 == 0)
            {
                vBox1.addChild(pianoButton);
            }
            else
            {
                vBox2.addChild(pianoButton);
            }
            pianoButtons.push(pianoButton);
        }
    }

    private function pianoButtonDown(event:MouseEvent)
    {
        var pianoButton:PianoButton = event.currentTarget;
        sendButtonMessage(pianoButton, true);
    }

    private function pianoButtonUp(event:MouseEvent)
    {
        sendButtonMessage(event.currentTarget, false);
    }

    private function sendButtonMessage(pianoButton:PianoButton, isDown:Bool)
    {
        var buttonNum:Int = pianoButtons.indexOf(pianoButton);
        var message:OscMessage = new OscMessage("rime");
        trace("button: " + "bt" + Std.string(buttonNum));
        message.addString("bt" + Std.string(buttonNum));
        message.addBool(true);
        client.send(message);
    }
}