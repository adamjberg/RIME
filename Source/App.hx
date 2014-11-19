package;

import controllers.MappingController;
import controllers.media.ViperMediaController;
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
import views.screens.ConnectionSetupScreen;
import views.screens.SensorsScreen;
import views.screens.ViperMediaScreen;
import views.screens.*;

class App extends VBox {

    private var headerBar:HeaderBar;
    private var gestureScreen:GestureListScreen;
    private var pianoButtonScreen:PianoButtonScreen;
    private var homeScreen:HomeScreen;
    private var sensorsScreen:SensorsScreen;
    private var connectionSetupScreen:ConnectionSetupScreen;
    private var viperMediaScreen:ViperMediaScreen;

    private var stack:Stack;
    private var client:Client;
    private var serverInfo:ServerInfo;
    private var sensorController:SensorController;
    private var sensors:Array<Sensor>;
    private var gestureController:GestureController;
    private var sensorDataController:SensorDataController;
    private var viperMediaController:ViperMediaController;

    public function new () {
        super();
    }

    override private function initialize()
    {
        super.initialize();

        percentWidth = 100;
        percentHeight = 100;
        style.backgroundColor = 0xDDDDDD;

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
        
        viperMediaController = new ViperMediaController(client);

        // Screen initialization
        homeScreen = new HomeScreen();
        pianoButtonScreen = new PianoButtonScreen(client);
        gestureScreen = new GestureListScreen(gestureController);
        sensorsScreen = new SensorsScreen(sensors);
        connectionSetupScreen = new ConnectionSetupScreen(client, serverInfo);
        viperMediaScreen = new ViperMediaScreen(viperMediaController);

        var mappingController:MappingController = new MappingController(client, pianoButtonScreen.pianoButtons, gestureController, sensorDataController);
        mappingController.addMappingFromFile("mapping1.json");

        homeScreen.onGesturesPressed.add(openGestureScreen);
        homeScreen.onConnectionSetupPressed.add(openConnectionSetup);
        homeScreen.onMediaPressed.add(openMediaScreen);
        homeScreen.onSensorsPressed.add(openSensorsScreen);

        ScreenManager.push(homeScreen);
    }

    private function openGestureScreen()
    {
        ScreenManager.push(gestureScreen);
    }

    private function openConnectionSetup()
    {
        ScreenManager.push(connectionSetupScreen);
    }

    private function openSensorsScreen()
    {
        ScreenManager.push(sensorsScreen);
    }

    private function openPianoButtonScreen()
    {
        ScreenManager.push(pianoButtonScreen);
    }

    private function openMediaScreen()
    {
        ScreenManager.push(viperMediaScreen);
    }
}