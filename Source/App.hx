package;

import controllers.*;
import controllers.media.*;
import controllers.PerformanceController;
import controllers.PresetController;
import database.Database;
import gestures.controllers.GestureController;
import haxe.ui.toolkit.containers.Stack;
import haxe.ui.toolkit.containers.VBox;
import models.Performance;
import models.sensors.Sensor;
import models.ServerInfo;
import controllers.Client;
import openfl.events.Event;
import views.HeaderBar;
import views.screens.ConnectionSetupScreen;
import views.screens.GestureRecognizeScreen;
import views.screens.PerformanceScreen;
import views.screens.PerformanceSelectScreen;
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
    private var performanceSelectScreen:PerformanceSelectScreen;
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
    private var performanceController:PerformanceController;
    private var viperCommandController:ViperCommandController;

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

        // Controller initialization
        client = new Client(serverInfo);
        sensorController = new SensorController();
        sensors = sensorController.sensors;
        sensorDataController = new SensorDataController(sensors);
        effectController = new EffectController(sensorDataController);
        gestureController = new GestureController(sensorDataController);
        viperMediaController = new ViperMediaController(client);
        effectToMediaController = new EffectToMediaController(effectController, viperMediaController);
        presetController = new PresetController(effectToMediaController);
        performanceController = new PerformanceController(presetController);
        viperCommandController = new ViperCommandController(presetController, effectToMediaController, effectController.activeEffects, client);


        // Screen initialization
        homeScreen = new HomeScreen();
        pianoButtonScreen = new PianoButtonScreen(client);
        gestureScreen = new GestureListScreen(gestureController);
        sensorsScreen = new SensorsScreen(sensors);
        connectionSetupScreen = new ConnectionSetupScreen(client, serverInfo);
        performanceSelectScreen = new PerformanceSelectScreen(performanceController.performances);
        gestureRecognizeScreen = new GestureRecognizeScreen(gestureController);
        viperMediaScreen = new ViperMediaScreen(viperMediaController);

        homeScreen.onGesturesPressed.add(openGestureScreen);
        homeScreen.onConnectionSetupPressed.add(openConnectionSetup);
        homeScreen.onMediaPressed.add(openMediaScreen);
        homeScreen.onSensorsPressed.add(openSensorsScreen);
        homeScreen.onPerformPressed.add(openPerformanceSelectScreen);

        performanceSelectScreen.onPerformanceSelected.add(openPerformanceScreen);

        ScreenManager.push(homeScreen);
        addEventListener(Event.ENTER_FRAME, onEnterFrame);
    }

    private function onEnterFrame(e:Event)
    {
        viperCommandController.update();
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

    private function openPerformanceSelectScreen()
    {
        ScreenManager.push(performanceSelectScreen);
    }

    private function openPerformanceScreen(performance:Performance)
    {
        performanceController.enablePerformance(performance);
        ScreenManager.push(new PerformanceScreen(performance));
    }

    private function openGestureRecognitionScreen()
    {
        ScreenManager.push(gestureRecognizeScreen);
    }
}