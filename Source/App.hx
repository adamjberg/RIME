package;

import haxe.ui.toolkit.containers.VBox;
import models.ServerInfo;
import openfl.events.AccelerometerEvent;
import openfl.events.Event;
import controllers.Client;
import views.HeaderBar;
import views.ServerInfoRenderer;

class App extends VBox {

    private var headerBar:HeaderBar;

    private var client:Client;

    private var serverInfo:ServerInfo;
    private var serverInfoRenderer:ServerInfoRenderer;

    public function new () {
        super();

        percentWidth = 100;
        percentHeight = 100;

        headerBar = new HeaderBar();

        serverInfo = new ServerInfo();
        serverInfoRenderer = new ServerInfoRenderer(serverInfo);

        client = new Client(serverInfo);

        addChild(headerBar);
        addChild(serverInfoRenderer);

        serverInfoRenderer.onSendButtonPressed.add(sendButtonPressed);
    }

    private function sendButtonPressed()
    {
        client.connect();
    }
}