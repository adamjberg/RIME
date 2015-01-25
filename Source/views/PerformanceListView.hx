package views;

import views.controls.ListView;
import models.Performance;

class PerformanceListView extends ListView {

    private var performances:Array<Performance>;

    public function new(?performances:Array<Performance>)
    {
        super();

        this.performances = performances;
        
        for(performance in performances)
        {
            dataSource.add(
            {
                text: performance.name
            });
        }
    }
}