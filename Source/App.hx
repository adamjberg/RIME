package;

import controllers.*;
import controllers.media.*;
import controllers.PerformanceController;
import controllers.PresetController;
import controllers.ScreenManager;
import database.Database;
import gestures.controllers.GestureController;
import haxe.ui.toolkit.containers.Stack;
import haxe.ui.toolkit.containers.VBox;
import models.effects.GestureEffect;
import models.media.ViperMedia;
import models.Performance;
import models.Preset;
import models.sensors.Sensor;
import models.ServerInfo;
import controllers.Client;
import openfl.events.Event;
import views.HeaderBar;
import views.screens.ConnectionSetupScreen;
import views.screens.DatabaseScreen;
import views.screens.EditMediaScreen;
import views.screens.GestureRecognizeScreen;
import views.screens.PerformanceScreen;
import views.screens.PerformanceSelectScreen;
import views.screens.SensorsScreen;
import views.screens.ViperMediaScreen;
import views.screens.EffectsScreen; 
import views.screens.PresetScreen; 
import views.screens.*;

class App extends VBox {

    private var headerBar:HeaderBar;
    private var gestureScreen:GestureListScreen;
    private var homeScreen:HomeScreen;
    private var sensorsScreen:SensorsScreen;
    private var connectionSetupScreen:ConnectionSetupScreen;
    private var viperMediaScreen:ViperMediaScreen;
    private var databaseScreen:DatabaseScreen;
    private var performanceSelectScreen:PerformanceSelectScreen;
    private var gestureRecognizeScreen:GestureRecognizeScreen;
    private var performanceScreen:PerformanceScreen;
    private var editMediaScreen:EditMediaScreen;
    private var effectsScreen:EffectsScreen; 
    private var presetScreen:PresetScreen; 

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

        // Controller initialization
        client = new Client();
        sensorController = new SensorController();
        sensors = sensorController.sensors;
        sensorDataController = new SensorDataController(sensors);
        gestureController = new GestureController(sensorDataController);
        effectController = new EffectController(sensorDataController, gestureController);
        viperMediaController = new ViperMediaController(client);
        databaseScreen = new DatabaseScreen();
        effectToMediaController = new EffectToMediaController(effectController, viperMediaController);
        presetController = new PresetController(effectToMediaController);
        performanceController = new PerformanceController(presetController);
        viperCommandController = new ViperCommandController(presetController, effectToMediaController, viperMediaController, gestureController, effectController.activeEffects, client);

        loadDatabase();

        // Screen initialization
        homeScreen = new HomeScreen();
        gestureScreen = new GestureListScreen(gestureController);
        sensorsScreen = new SensorsScreen(sensors);
        connectionSetupScreen = new ConnectionSetupScreen(client, serverInfo);
        performanceSelectScreen = new PerformanceSelectScreen(performanceController, presetController);
        gestureRecognizeScreen = new GestureRecognizeScreen(gestureController);
        effectsScreen = new EffectsScreen(effectController, sensorDataController); 
        viperMediaScreen = new ViperMediaScreen(viperMediaController);
        performanceScreen = new PerformanceScreen();
        editMediaScreen = new EditMediaScreen(viperMediaController);
        presetScreen = new PresetScreen(presetController, effectToMediaController, effectController, viperMediaController); 

        homeScreen.onGesturesPressed.add(openGestureScreen);
        homeScreen.onConnectionSetupPressed.add(openConnectionSetup);
        homeScreen.onMediaPressed.add(openMediaScreen);
        homeScreen.onDatabasePressed.add(openDatabaseScreen);
        homeScreen.onSensorsPressed.add(openSensorsScreen);
        homeScreen.onEffectsPressed.add(openEffectsScreen); 
        homeScreen.onPerformPressed.add(openPerformanceSelectScreen);
        homeScreen.onPresetsPressed.add(openPresetScreen); 

        performanceSelectScreen.onPerformanceSelected.add(openPerformanceScreen);
        performanceScreen.onPresetStateChanged.add(presetStatusChanged);
        performanceScreen.onClosed.add(disableAllPresets);

        viperMediaScreen.onMediaSelected.add(openEditMediaScreen);

        databaseScreen.onReloadPressed.add(loadDatabase);

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

    private function openMediaScreen()
    {
        ScreenManager.push(viperMediaScreen);
    }

    private function openDatabaseScreen()
    {
        ScreenManager.push(databaseScreen);
    }

    private function openPerformanceSelectScreen()
    {
        ScreenManager.push(performanceSelectScreen);
    }

    private function openPerformanceScreen(performance:Performance)
    {
        performanceController.enablePerformance(performance);
        performanceScreen.setPerformance(performance);
        ScreenManager.push(performanceScreen);
    }

    private function openEditMediaScreen(media:ViperMedia)
    {
        editMediaScreen.setViperMedia(media);
        ScreenManager.push(editMediaScreen);
    }

    private function openPresetScreen()
    {
        ScreenManager.push(presetScreen); 
    }
    
    private function presetStatusChanged(preset:Preset, enabled:Bool)
    {
        if(enabled)
        {
            presetController.enablePreset(preset);
        }
        else
        {
            presetController.disablePreset(preset);
        }
        updateActiveGestures();
    }

    private function disableAllPresets()
    {
        for(preset in presetController.presets)
        {
            presetController.disablePreset(preset);
        }
        updateActiveGestures();
    }

    private function updateActiveGestures()
    {
        gestureController.disableAllGestures();
        for(effect in effectController.activeEffects)
        {
            if(Std.is(effect, GestureEffect))
            {
                var gestureEffect:GestureEffect = cast(effect, GestureEffect);
                gestureController.enableGesture(gestureEffect.gestureModel);
            }
        }
    }

    private function loadDatabase()
    {
        Database.instance.load();
        Database.instance.db.errors = new Array<Dynamic>();
        serverInfo = Database.instance.getServerInfo();
        client.serverInfo = serverInfo;
        System.deviceID = Database.instance.getDeviceID();
        effectController.loadEffectsFromDB();
        viperMediaController.loadMediaListFromDB();
        effectToMediaController.loadEffectsToMediaListFromDB();
        presetController.loadPresetsFromDB();
        performanceController.loadPerformancesFromDB();
    }

    private function openEffectsScreen()
    {
        ScreenManager.push(effectsScreen); 
    }
}