package views;

import haxe.ui.toolkit.containers.VBox;
import models.sensors.Sensor;
import models.ServerInfo;
import controllers.Client;
import views.HeaderBar;
import views.SensorScrollList;
import views.ServerInfoRenderer;

class HomeScreen extends VBox {

    private var headerBar:HeaderBar;
    private var client:Client;

    private var serverInfo:ServerInfo;
    private var serverInfoRenderer:ServerInfoRenderer;

    private var sensors:Array<Sensor>;

    public function new(?headerBar:HeaderBar, ?sensors:Array<Sensor>, ?client:Client) {
        super();

        this.headerBar;
        this.sensors = sensors;
        this.client = client;

        percentWidth = 100;
        percentHeight = 100;
        style.backgroundColor = 0xDDDDDD;
        style.paddingBottom = 10;

        serverInfo = new ServerInfo();
        serverInfoRenderer = new ServerInfoRenderer(serverInfo);

        var sensorList:SensorScrollList = new SensorScrollList(sensors);
        addChild(sensorList);

        addChild(serverInfoRenderer);

        serverInfoRenderer.onSendButtonPressed.add(sendButtonPressed);
    }
    
    private function sendButtonPressed()
    {
        #if !neko
            client.connect();
        #end
    }
}