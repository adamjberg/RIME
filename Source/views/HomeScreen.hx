package views;

import controllers.ScreenManager;
import haxe.ui.toolkit.containers.VBox;
import haxe.ui.toolkit.controls.Button;
import models.sensors.Sensor;
import models.ServerInfo;
import controllers.Client;
import openfl.events.MouseEvent;
import views.HeaderBar;
import views.PianoButtonScreen;
import views.SensorScrollList;
import views.ServerInfoRenderer;

class HomeScreen extends VBox {

    private var headerBar:HeaderBar;
    private var client:Client;

    private var serverInfo:ServerInfo;
    private var serverInfoRenderer:ServerInfoRenderer;

    private var sensors:Array<Sensor>;

    public function new(?headerBar:HeaderBar, ?sensors:Array<Sensor>, ?client:Client, ?serverInfo:ServerInfo) {
        super();

        this.headerBar;
        this.sensors = sensors;
        this.client = client;
        this.serverInfo = serverInfo;

        percentWidth = 100;
        percentHeight = 100;
        style.backgroundColor = 0xDDDDDD;
        style.paddingBottom = 10;

        serverInfoRenderer = new ServerInfoRenderer(serverInfo);

        var sensorList:SensorScrollList = new SensorScrollList(sensors);
        sensorList.percentHeight = 60;
        addChild(sensorList);

        var openPianoScreenButton:Button = new Button();
        openPianoScreenButton.text = "Open Piano Screen";
        openPianoScreenButton.percentWidth = 100;
        openPianoScreenButton.percentHeight = 20;
        openPianoScreenButton.addEventListener(MouseEvent.CLICK, openPianoScreen);
        addChild(openPianoScreenButton);

        serverInfoRenderer.percentHeight = 20;
        addChild(serverInfoRenderer);

        serverInfoRenderer.onSendButtonPressed.add(sendButtonPressed);
    }
    
    private function openPianoScreen(e:MouseEvent)
    {
        ScreenManager.push(new PianoButtonScreen(client));
    }

    private function sendButtonPressed()
    {
        client.connect();
    }
}