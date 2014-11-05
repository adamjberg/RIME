package views;

import controllers.ScreenManager;
import haxe.ui.toolkit.containers.VBox;
import haxe.ui.toolkit.controls.Button;
import models.sensors.Sensor;
import models.ServerInfo;
import controllers.Client;
import msignal.Signal.Signal0;
import openfl.events.MouseEvent;
import views.HeaderBar;
import views.PianoButtonScreen;
import views.SensorScrollList;
import views.ServerInfoRenderer;
import views.TestPositionScreen;

class HomeScreen extends VBox {

    public var onOpenGestureScreenButtonPressed:Signal0 = new Signal0();

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
        openPianoScreenButton.percentHeight = 10;
        openPianoScreenButton.addEventListener(MouseEvent.CLICK, openPianoScreen);
        addChild(openPianoScreenButton);

        var openTestScreenButton:Button = new Button();
        openTestScreenButton.text = "Open Test Screen";
        openTestScreenButton.percentWidth = 100;
        openTestScreenButton.percentHeight = 10;
        openTestScreenButton.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) {
            ScreenManager.push(new TestPositionScreen(client));
            });
        addChild(openTestScreenButton);

        var onOpenGestureScreenButton:Button = new Button();
        onOpenGestureScreenButton.text = "Open Gesture Screen";
        onOpenGestureScreenButton.percentWidth = 100;
        onOpenGestureScreenButton.percentHeight = 10;
        onOpenGestureScreenButton.onClick = function(e)
        {
            onOpenGestureScreenButtonPressed.dispatch();
        }
        addChild(onOpenGestureScreenButton);

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