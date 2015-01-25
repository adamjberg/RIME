package views.screens;

import controllers.PerformanceController;
import haxe.ui.toolkit.containers.ListView;
import haxe.ui.toolkit.data.ArrayDataSource;
import haxe.ui.toolkit.events.UIEvent;
import models.Performance;
import msignal.Signal.Signal1;
import views.controls.FullWidthButton;

class PerformanceSelectScreen extends Screen {

    public var onPerformanceSelected:Signal1<Performance> = new Signal1<Performance>();

    private var performances:Array<Performance>;
    private var performanceListView:ListView;
    private var createPerformanceButton:FullWidthButton;

    public function new(?performances:Array<Performance>)
    {
        super();

        this.performances = performances;

        performanceListView = new ListView();
        performanceListView.percentHeight = 100;
        performanceListView.percentWidth = 100;

        var dataSource:ArrayDataSource = new ArrayDataSource();

        for(performance in performances)
        {
            dataSource.add(
            {
                text: performance.name,
            });
        }
        performanceListView.dataSource = dataSource;
        performanceListView.addEventListener(UIEvent.CHANGE, performanceSelected);
        addChild(performanceListView);

        createPerformanceButton = new FullWidthButton("New");
        addChild(createPerformanceButton);
    }

    private function performanceSelected(e:UIEvent)
    {
        var performance:Performance = performances[performanceListView.selectedIndex];
        onPerformanceSelected.dispatch(performance);
    }
}