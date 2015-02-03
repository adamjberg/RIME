package views.screens;

import haxe.ui.toolkit.events.UIEvent;
import models.Performance;
import msignal.Signal.Signal1;
import views.controls.FullWidthButton;
import views.PerformanceListView;
import views.screens.NewPerformanceScreen;
import controllers.PresetController; 
import controllers.PerformanceController; 
import controllers.ScreenManager; 

class PerformanceSelectScreen extends Screen {

    public var onPerformanceSelected:Signal1<Performance> = new Signal1<Performance>();

    private var performances:Array<Performance>;
    private var performanceListView:PerformanceListView;
    private var createPerformanceButton:FullWidthButton;
    private var performanceController:PerformanceController; 

    private var presetController:PresetController;  

    public function new(?performanceController:PerformanceController, ?presetController:PresetController)
    {
        super();
        this.performanceController = performanceController; 
        this.performances = performanceController.performances;
        this.presetController = presetController; 

        performanceListView = new PerformanceListView(performanceController);
        performanceListView.percentHeight = 100; 
        addChild(performanceListView);
        performanceListView.addEventListener(UIEvent.CHANGE, performanceSelected);

        createPerformanceButton = new FullWidthButton("Create New Performance");
        createPerformanceButton.onClick = createPerformanceButtonPressed; 
        addChild(createPerformanceButton);
    }

    private function performanceSelected(e:UIEvent)
    {
        var performance:Performance = performances[performanceListView.selectedIndex];
        onPerformanceSelected.dispatch(performance);
    }

    private function createPerformanceButtonPressed(e:UIEvent)
    {
        var newPerformanceScreen:NewPerformanceScreen = new NewPerformanceScreen(presetController, performanceController); 
        ScreenManager.push(newPerformanceScreen); 
    }
}