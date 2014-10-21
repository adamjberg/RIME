package views;

import haxe.ui.toolkit.containers.HBox;
import haxe.ui.toolkit.containers.VBox;
import haxe.ui.toolkit.controls.Button;
import haxe.ui.toolkit.controls.Text;
import haxe.ui.toolkit.controls.TextInput;
import models.ServerInfo;
import msignal.Signal;
import openfl.events.Event;
import openfl.events.MouseEvent;

class ServerInfoRenderer extends VBox {

    public var onSendButtonPressed:Signal0 = new Signal0();

    private var hBox:HBox;
    private var ipAddressLabel:Text;
    private var ipAddress:TextInput;
    private var portNumberLabel:Text;
    private var portNumber:TextInput;
    private var sendButton:Button;

    private var serverInfo:ServerInfo;

    public function new(?serverInfo:ServerInfo)
    {
        super();

        this.serverInfo = serverInfo;

        percentWidth = 100;

        hBox = new HBox();
        hBox.percentWidth = 100;
        hBox.horizontalAlign = "center";
        addChild(hBox);

        ipAddressLabel = new Text();
        ipAddressLabel.text = "IP:";
        ipAddressLabel.verticalAlign = "center";
        hBox.addChild(ipAddressLabel);

        ipAddress = new TextInput();
        ipAddress.maxChars = 15;
        ipAddress.percentWidth = 50;
        ipAddress.verticalAlign = "center";
        ipAddress.text = serverInfo.ipAddress;
        ipAddress.addEventListener(Event.CHANGE, ipAddressChanged);
        hBox.addChild(ipAddress);

        portNumberLabel = new Text();
        portNumberLabel.text = "Port:";
        hBox.addChild(portNumberLabel);

        portNumber = new TextInput();
        portNumber.verticalAlign = "center";
        portNumber.text = Std.string(serverInfo.portNumber);
        portNumber.addEventListener(Event.CHANGE, portNumberChanged);
        portNumber.percentWidth = 50;
        hBox.addChild(portNumber);

        sendButton = new Button();
        sendButton.text = "Send";
        sendButton.addEventListener(MouseEvent.CLICK, sendButtonPressed);
        hBox.addChild(sendButton);
    }

    private function portNumberChanged(e:Event)
    {
        serverInfo.portNumber = Std.parseInt(portNumber.text);
    }

    private function ipAddressChanged(e:Event)
    {
        serverInfo.ipAddress = ipAddress.text;
    }

    private function sendButtonPressed(e:Event)
    {
        onSendButtonPressed.dispatch();
    }
}