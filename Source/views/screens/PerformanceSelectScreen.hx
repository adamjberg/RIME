package views.screens;

import haxe.ui.toolkit.events.UIEvent;
import models.Performance;
import msignal.Signal.Signal1;
import views.controls.FullWidthButton;
import views.PerformanceListView;

class PerformanceSelectScreen extends Screen {

    public var onPerformanceSelected:Signal1<Performance> = new Signal1<Performance>();

    private var performances:Array<Performance>;
    private var performanceListView:PerformanceListView;
    private var createPerformanceButton:FullWidthButton;

    public function new(?performances:Array<Performance>)
    {
        super();

        this.performances = performances;

        performanceListView = new PerformanceListView(performances);
        addChild(performanceListView);
        performanceListView.addEventListener(UIEvent.CHANGE, performanceSelected);

        createPerformanceButton = new FullWidthButton("New");
        // TODO: Once there is an edit performance screen enable
        //addChild(createPerformanceButton);
    }

    private function performanceSelected(e:UIEvent)
    {
        var performance:Performance = performances[performanceListView.selectedIndex];
        onPerformanceSelected.dispatch(performance);
    }
}