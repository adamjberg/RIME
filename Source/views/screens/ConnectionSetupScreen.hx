package views.screens;

import controllers.Client;
import haxe.ui.toolkit.events.UIEvent;
import models.commands.ViperCommand;
import models.ServerInfo;
import views.controls.LabelledTextInput;
import views.screens.Screen;
import views.ServerInfoRenderer;

class ConnectionSetupScreen extends Screen {

    private var client:Client;
    private var serverInfo:ServerInfo;

    private var deviceId:LabelledTextInput;
    private var serverInfoRenderer:ServerInfoRenderer;

    public function new(?client:Client, ?serverInfo:ServerInfo)
    {
        super();

        this.client = client;
        this.serverInfo = serverInfo;

        deviceId = new LabelledTextInput("Device ID:");
        deviceId.setText(System.deviceID);
        addChild(deviceId);

        deviceId.input.addEventListener(UIEvent.CHANGE, onDeviceIdChanged);

        serverInfoRenderer = new ServerInfoRenderer(serverInfo);
        serverInfoRenderer.onSendButtonPressed.add(sendButtonPressed);
    }

    override private function initialize()
    {
        addChild(serverInfoRenderer);
        super.initialize();
    }

    private function onDeviceIdChanged(e:UIEvent)
    {
        System.deviceID = deviceId.getText();
    }

    private function sendButtonPressed()
    {
        client.connect();
    }
}