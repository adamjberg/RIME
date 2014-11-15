package;

import controllers.MappingController;
import controllers.ScreenManager;
import controllers.SensorController;
import controllers.SensorDataController;
import gestures.controllers.GestureController;
import haxe.ui.toolkit.containers.Stack;
import haxe.ui.toolkit.containers.VBox;
import models.sensors.Sensor;
import models.ServerInfo;
import controllers.Client;
import views.HeaderBar;
import views.screens.*;

class App extends VBox {

    private var headerBar:HeaderBar;
    private var gestureScreen:GestureListScreen;
    private var pianoButtonScreen:PianoButtonScreen;
    private var homeScreen:HomeScreen;

    private var stack:Stack;
    private var client:Client;
    private var serverInfo:ServerInfo;
    private var sensorController:SensorController;
    private var sensors:Array<Sensor>;
    private var gestureController:GestureController;
    private var sensorDataController:SensorDataController;

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

        sensorDataController = new SensorDataController(sensors);

        gestureController = new GestureController(sensorDataController);

        client = new Client(serverInfo);

        homeScreen = new HomeScreen(
            headerBar,
            sensors,
            client,
            serverInfo
        );

        pianoButtonScreen = new PianoButtonScreen(client);

        var mappingController:MappingController = new MappingController(client, pianoButtonScreen.pianoButtons, gestureController, sensorDataController);
        mappingController.addMappingFromFile("mapping1.json");

        homeScreen.onOpenGestureScreenButtonPressed.add(openGestureScreen);
        homeScreen.onOpenPianoButtonScreenButtonPressed.add(openPianoButtonScreen);

        ScreenManager.push(homeScreen);
    }

    private function openGestureScreen()
    {
        gestureScreen = new GestureListScreen(gestureController);
        ScreenManager.push(gestureScreen);
    }

    private function openPianoButtonScreen()
    {
        ScreenManager.push(pianoButtonScreen);
    }
}