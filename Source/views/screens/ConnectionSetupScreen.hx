package views.screens;

import controllers.Client;
import models.ServerInfo;
import views.screens.Screen;
import views.ServerInfoRenderer;

class ConnectionSetupScreen extends Screen {

    private var client:Client;
    private var serverInfo:ServerInfo;

    private var serverInfoRenderer:ServerInfoRenderer;

    public function new(?client:Client, ?serverInfo:ServerInfo)
    {
        super();

        this.client = client;
        this.serverInfo = serverInfo;

        serverInfoRenderer = new ServerInfoRenderer(serverInfo);
        serverInfoRenderer.onSendButtonPressed.add(sendButtonPressed);
    }

    override private function initialize()
    {
        addChild(serverInfoRenderer);
        super.initialize();
    }

    private function sendButtonPressed()
    {
        client.connect();
    }
}