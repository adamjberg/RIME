package views;

import controllers.Client;
import haxe.ui.toolkit.containers.VBox;
import haxe.ui.toolkit.controls.Button;
import haxe.ui.toolkit.controls.TextInput;
import models.commands.ViperCreateImageCommand;
import models.commands.ViperUpdatePositionCommand;
import openfl.events.MouseEvent;
import osc.OscMessage;

class TestPositionScreen extends VBox {

    private var client:Client;

    private var xInput:TextInput;
    private var yInput:TextInput;
    private var sendButton:Button;

    public function new(?client:Client)
    {
        super();

        this.client = client;

        this.percentWidth = 100;
        this.percentHeight = 100;

        xInput = new TextInput();
        xInput.percentHeight = 20;
        xInput.percentWidth = 100;
        addChild(xInput);

        yInput = new TextInput();
        yInput.percentHeight = 20;
        yInput.percentWidth = 100;
        addChild(yInput);

        sendButton = new Button();
        sendButton.percentWidth = 100;
        sendButton.text = "SEND!";
        addChild(sendButton);

        sendButton.addEventListener(MouseEvent.CLICK, send);
    }

    private function send(e:MouseEvent)
    {
        var createCommand:ViperCreateImageCommand = new ViperCreateImageCommand(0, 0.2, 0.5);
        var updateCommand:ViperUpdatePositionCommand = new ViperUpdatePositionCommand(0, Std.parseFloat(xInput.text), Std.parseFloat(yInput.text));

        client.send(updateCommand.fillOscMessage(createCommand.fillOscMessage()));
    }

}