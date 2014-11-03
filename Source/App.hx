package;

import controllers.ScreenManager;
import controllers.SensorController;
import gestures.controllers.GestureController;
import haxe.ui.toolkit.containers.Stack;
import haxe.ui.toolkit.containers.VBox;
import models.sensors.Sensor;
import models.ServerInfo;
import controllers.Client;
import views.GestureScreen;
import views.HeaderBar;
import views.HomeScreen;

class App extends VBox {

    private var headerBar:HeaderBar;
    private var gestureScreen:GestureScreen;
    private var homeScreen:HomeScreen;

    private var stack:Stack;
    private var client:Client;
    private var serverInfo:ServerInfo;
    private var sensorController:SensorController;
    private var sensors:Array<Sensor>;
    private var gestureController:GestureController;

    public function new () {
        super();

        percentWidth = 100;
        percentHeight = 100;
        style.backgroundColor = 0xDDDDDD;
        style.paddingBottom = 10;

        headerBar = new HeaderBar();
        addChild(headerBar);

        stack = new Stack();
        stack.percentHeight = 100;
        stack.percentWidth = 100;
        ScreenManager.init(stack, headerBar);
        addChild(stack);

        serverInfo = new ServerInfo();

        sensorController = new SensorController();
        sensors = sensorController.sensors;

        gestureController = new GestureController(sensors);

        client = new Client(serverInfo, sensors);

        homeScreen = new HomeScreen(
            headerBar,
            sensors,
            client,
            serverInfo
        );

        gestureScreen = new GestureScreen(gestureController);

        ScreenManager.push(gestureScreen);
    }
}