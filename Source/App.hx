package;

import controllers.*;
import controllers.media.*;
import controllers.PresetController;
import database.Database;
import gestures.controllers.GestureController;
import haxe.ui.toolkit.containers.Stack;
import haxe.ui.toolkit.containers.VBox;
import models.sensors.Sensor;
import models.ServerInfo;
import controllers.Client;
import views.HeaderBar;
import views.screens.ConnectionSetupScreen;
import views.screens.GestureRecognizeScreen;
import views.screens.PerformSelectScreen;
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
    private var performSelectScreen:PerformSelectScreen;
    private var gestureRecognizeScreen:GestureRecognizeScreen;

    private var stack:Stack;
    private var client:Client;
    private var serverInfo:ServerInfo;
    private var sensorController:SensorController;
    private var sensors:Array<Sensor>;
    private var gestureController:GestureController;
    private var sensorDataController:SensorDataController;
    private var effectController:EffectController;
    private var viperMediaController:ViperMediaController;
    private var effectToMediaController:EffectToMediaController;
    private var presetController:PresetController;

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

        serverInfo = Database.instance.getServerInfo();

        sensorController = new SensorController();
        sensors = sensorController.sensors;

        sensorDataController = new SensorDataController(sensors);
        effectController = new EffectController(sensorDataController);

        gestureController = new GestureController(sensorDataController);

        client = new Client(serverInfo);

        // Screen initialization
        homeScreen = new HomeScreen();
        pianoButtonScreen = new PianoButtonScreen(client);
        gestureScreen = new GestureListScreen(gestureController);
        sensorsScreen = new SensorsScreen(sensors);
        connectionSetupScreen = new ConnectionSetupScreen(client, serverInfo);
        performSelectScreen = new PerformSelectScreen();
        gestureRecognizeScreen = new GestureRecognizeScreen(gestureController);

        viperMediaController = new ViperMediaController(client);
        effectToMediaController = new EffectToMediaController(effectController, viperMediaController);
        presetController = new PresetController(effectToMediaController);

        viperMediaScreen = new ViperMediaScreen(viperMediaController);

        homeScreen.onGesturesPressed.add(openGestureScreen);
        homeScreen.onConnectionSetupPressed.add(openConnectionSetup);
        homeScreen.onMediaPressed.add(openMediaScreen);
        homeScreen.onSensorsPressed.add(openSensorsScreen);
        homeScreen.onPerformPressed.add(openPerformSelectScreen);

        performSelectScreen.onOpenGesturePressed.add(openGestureRecognitionScreen);

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

    private function openPerformSelectScreen()
    {
        ScreenManager.push(performSelectScreen);
    }

    private function openGestureRecognitionScreen()
    {
        ScreenManager.push(gestureRecognizeScreen);
    }
}