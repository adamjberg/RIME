package views;

import database.Database;
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

    public var onConnectButtonPressed:Signal0 = new Signal0();

    private var ipAddress:LabelledTextInput;
    private var portNumber:LabelledTextInput;
    private var connectButton:Button;

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

        connectButton = new FullWidthButton();
        setConnected(false);
        connectButton.addEventListener(MouseEvent.CLICK, connectButtonPressed);
        addChild(connectButton);
    }

    public function setConnected(connected:Bool)
    {
        if(connected)
        {
            connectButton.text = "Disconnect";
        }
        else
        {
            connectButton.text = "Connect";
        }
    }

    private function portNumberChanged(e:Event)
    {
        serverInfo.portNumber = Std.parseInt(portNumber.getText());
        Database.instance.saveServerInfo(serverInfo);
    }

    private function ipAddressChanged(e:Event)
    {
        serverInfo.ipAddress = ipAddress.getText();
        Database.instance.saveServerInfo(serverInfo);
    }

    private function connectButtonPressed(e:Event)
    {
        onConnectButtonPressed.dispatch();
    }
}