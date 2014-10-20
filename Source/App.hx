package;

import haxe.ui.toolkit.containers.VBox;
import models.sensors.Sensor;
import models.sensors.Accelerometer;
import models.ServerInfo;
import openfl.events.AccelerometerEvent;
import openfl.events.Event;
import controllers.Client;
import views.HeaderBar;
import views.SensorScrollList;
import views.ServerInfoRenderer;

class App extends VBox {

    private var headerBar:HeaderBar;

    private var client:Client;

    private var serverInfo:ServerInfo;
    private var serverInfoRenderer:ServerInfoRenderer;

    private var sensors:Array<Sensor>;
    private var accelerometer:Sensor;

    public function new () {
        super();

        percentWidth = 100;
        percentHeight = 100;
        style.backgroundColor = 0xDDDDDD;
        style.paddingBottom = 10;

        headerBar = new HeaderBar();

        serverInfo = new ServerInfo();
        serverInfoRenderer = new ServerInfoRenderer(serverInfo);

        accelerometer = new Accelerometer();
        sensors = [
            accelerometer
        ];

        #if !neko
            client = new Client(serverInfo, sensors);
        #end

        addChild(headerBar);

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