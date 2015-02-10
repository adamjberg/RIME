package views.screens;

import controllers.ScreenManager;
import haxe.ui.toolkit.controls.Button;
import msignal.Signal.Signal0;
import openfl.events.MouseEvent;
import views.controls.FullWidthButton;
import views.screens.Screen;
import haxe.ui.toolkit.containers.VBox;

class HomeScreen extends Screen {

    public var onConnectionSetupPressed:Signal0 = new Signal0();
    public var onMediaPressed:Signal0 = new Signal0();
    public var onDatabasePressed:Signal0 = new Signal0();
    public var onSensorsPressed:Signal0 = new Signal0();
    public var onGesturesPressed:Signal0 = new Signal0();
    public var onPerformPressed:Signal0 = new Signal0();
    public var onEffectsPressed:Signal0 = new Signal0(); 
    public var onPresetsPressed:Signal0 = new Signal0(); 

    private var spacer1:VBox; 
    private var spacer2:VBox;
    private var spacer3:VBox; 


    private var fullWidthButtonArray:Array<FullWidthButton> = new Array<FullWidthButton>(); 

    private var buttonStrings:Array<String> =
    [
        "Connection Setup",
        "Database",
        "Sensors",
        "Media",
        "Effects",
        "Gestures",
        "Presets",
        "Perform", 
    ];
    private var buttonPressedSignals:Array<Signal0> = new Array<Signal0>();
    private var openScreenButtons:Array<Button> = new Array<Button>();

    public function new() {
        super();

        buttonPressedSignals.push(onConnectionSetupPressed);
        buttonPressedSignals.push(onDatabasePressed);
        buttonPressedSignals.push(onSensorsPressed);
        buttonPressedSignals.push(onMediaPressed);
        buttonPressedSignals.push(onEffectsPressed); 
        buttonPressedSignals.push(onGesturesPressed);
        buttonPressedSignals.push(onPresetsPressed); 
        buttonPressedSignals.push(onPerformPressed);
        
    }

    override private function initialize()
    {
        super.initialize();

        spacer1 = new VBox(); 
        spacer1.percentWidth = 100; 
        spacer1.percentHeight = 10; 

        spacer2 = new VBox(); 
        spacer2.percentWidth = 100; 
        spacer2.percentHeight = 10; 

        spacer3 = new VBox(); 
        spacer3.percentWidth = 100; 
        spacer3.percentHeight = 10; 


        var connectionButton:FullWidthButton = new FullWidthButton("Connection Setup"); 
        fullWidthButtonArray.push(connectionButton); 
        openScreenButtons.push(connectionButton);

        addChild(connectionButton); 
        addChild(spacer1); 

        var databaseButton:FullWidthButton = new FullWidthButton("Database"); 
        fullWidthButtonArray.push(databaseButton);
        openScreenButtons.push(databaseButton);

        addChild(databaseButton); 

        var sensorsButton:FullWidthButton = new FullWidthButton("Sensors"); 
        fullWidthButtonArray.push(sensorsButton); 
        openScreenButtons.push(sensorsButton);

        addChild(sensorsButton); 
        addChild(spacer2); 

        var mediaButton:FullWidthButton = new FullWidthButton("Media"); 
        fullWidthButtonArray.push(mediaButton); 
        openScreenButtons.push(mediaButton);

        addChild(mediaButton); 

        var effectsButton:FullWidthButton = new FullWidthButton("Effects"); 
        fullWidthButtonArray.push(effectsButton); 
        openScreenButtons.push(effectsButton);

        addChild(effectsButton);

        var gesturesButton:FullWidthButton = new FullWidthButton("Gestures"); 
        fullWidthButtonArray.push(gesturesButton);
        openScreenButtons.push(gesturesButton);

        addChild(gesturesButton); 

        var presetsButton:FullWidthButton = new FullWidthButton("Presets"); 
        fullWidthButtonArray.push(presetsButton); 
        openScreenButtons.push(presetsButton);

        addChild(presetsButton);
        addChild(spacer3);

        var performButton:FullWidthButton = new FullWidthButton("Perform"); 
        fullWidthButtonArray.push(performButton); 
        openScreenButtons.push(performButton);

        addChild(performButton); 

        for( i in 0...fullWidthButtonArray.length){
            fullWidthButtonArray[i].onClick = function(e)
            {
                buttonPressedSignals[i].dispatch(); 
            }
        }


    }
}