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
import views.controls.FullWidthButton;
import views.controls.LabelledTextInput;

class ServerInfoRenderer extends VBox {

    public var onSendButtonPressed:Signal0 = new Signal0();

    private var ipAddress:LabelledTextInput;
    private var portNumber:LabelledTextInput;
    private var sendButton:Button;

    private var serverInfo:ServerInfo;

    public function new(?serverInfo:ServerInfo)
    {
        super();
        this.serverInfo = serverInfo;
        percentWidth = 100;
        percentHeight = 100;
    }

    override private function initialize()
    {
        super.initialize();

        ipAddress = new LabelledTextInput("IP:");
        ipAddress.verticalAlign = "center";
        ipAddress.setText(serverInfo.ipAddress);
        ipAddress.addEventListener(Event.CHANGE, ipAddressChanged);
        addChild(ipAddress);

        portNumber = new LabelledTextInput("Port:");
        portNumber.verticalAlign = "center";
        portNumber.setText(Std.string(serverInfo.portNumber));
        portNumber.addEventListener(Event.CHANGE, portNumberChanged);
        addChild(portNumber);

        sendButton = new FullWidthButton("Send");
        sendButton.addEventListener(MouseEvent.CLICK, sendButtonPressed);
        addChild(sendButton);
    }

    private function portNumberChanged(e:Event)
    {
        serverInfo.portNumber = Std.parseInt(portNumber.getText());
    }

    private function ipAddressChanged(e:Event)
    {
        serverInfo.ipAddress = ipAddress.getText();
    }

    private function sendButtonPressed(e:Event)
    {
        onSendButtonPressed.dispatch();
    }
}