package views.screens;

import controllers.Client;
import database.Database;
import haxe.ui.toolkit.events.UIEvent;
import models.commands.ViperCommand;
import models.ServerInfo;
import views.controls.LabelledTextInput;
import views.screens.Screen;
import views.ServerInfoRenderer;

class ConnectionSetupScreen extends Screen {

    private var client:Client;
    private var serverInfo:ServerInfo;

    private var deviceID:LabelledTextInput;
    private var serverInfoRenderer:ServerInfoRenderer;

    public function new(?client:Client, ?serverInfo:ServerInfo)
    {
        super();

        this.client = client;
        this.serverInfo = serverInfo;

        deviceID = new LabelledTextInput("Device ID:");
        deviceID.setText(System.deviceID);
        addChild(deviceID);

        deviceID.input.addEventListener(UIEvent.CHANGE, ondeviceIDChanged);

        serverInfoRenderer = new ServerInfoRenderer(serverInfo);
        serverInfoRenderer.onConnectButtonPressed.add(connectButtonPressed);
    }

    override private function initialize()
    {
        addChild(serverInfoRenderer);
        super.initialize();
    }

    private function ondeviceIDChanged(e:UIEvent)
    {
        System.deviceID = deviceID.getText();
        Database.instance.saveDeviceID(System.deviceID);
    }

    private function connectButtonPressed()
    {
        if(client.connected)
        {
            client.disconnect();
        }
        else
        {
            client.connect();
        }
        serverInfoRenderer.setConnected(client.connected);
    }
}