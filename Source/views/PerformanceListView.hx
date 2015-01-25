package views;

import haxe.ui.toolkit.containers.ListView;
import models.Performance;

class PerformanceListView extends ListView {

    private var performances:Array<Performance>;

    public function new(?performances:Array<Performance>)
    {
        super();

        this.performances = performances;

        this.percentHeight = 100;
        this.percentWidth = 100;
        
        for(performance in performances)
        {
            dataSource.add(
            {
                text: performance.name
            });
        }
    }
}