package views;

import controllers.Client;
import haxe.ui.toolkit.containers.VBox;
import haxe.ui.toolkit.controls.Button;
import haxe.ui.toolkit.controls.TextInput;
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
        var message:OscMessage = new OscMessage("rime");

        message.addString("command");
        message.addString("create");
        message.addString("id");
        message.addInt(0);
        message.addString("xPos");
        message.addFloat(0);
        message.addString("yPos");
        message.addFloat(0);

        message.addString("command");
        message.addString("update");
        message.addString("id");
        message.addInt(0);
        message.addString("xPos");
        message.addFloat(Std.parseFloat(xInput.text));
        message.addString("yPos");
        message.addFloat(Std.parseFloat(yInput.text));

        client.send(message);
    }

}