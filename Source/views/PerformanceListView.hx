package views;

import views.controls.ListView;
import models.Performance;
import controllers.PerformanceController; 
import views.renderers.CustomComponentRenderer;
import controllers.ScreenManager; 


class PerformanceListView extends ListView {

    private var performances:Array<Performance>;
    private var performanceController:PerformanceController; 

    public function new(?performanceController:PerformanceController)
    {
        super();

        this.performanceController = performanceController; 
        this.performances = new Array<Performance>(); 
        this.performances = performanceController.performances;
        
        performanceController.onUpdated.add(populate);
        populate(); 
    }

    private function populate()
    {
        dataSource.removeAll(); 

        var pos:Int = 0; 
        for(performance in performances)
        {
            dataSource.add(
            {
                text: performance.name, 
                componentType: "button",
                componentValue: "delete"
            }); 
            var item:CustomComponentRenderer = cast(getItem(pos++), CustomComponentRenderer);
            item.component.onClick = function(e){
                    deletePerformance(performance); 
            };
        }
    }

    private function deletePerformance(performance:Performance)
    {
        performanceController.deletePerformance(performance); 
    }
}