package views;

import controllers.ScreenManager;
import views.controls.ListView;
import gestures.controllers.GestureController;
import gestures.models.GestureModel;
import haxe.ui.toolkit.controls.Button;
import haxe.ui.toolkit.controls.Text;
import haxe.ui.toolkit.core.renderers.ComponentItemRenderer;
import views.renderers.CustomComponentRenderer;
import views.screens.GestureEditScreen;

class GestureList extends ListView {

    private var gestureController:GestureController;
    private var gestures:Array<GestureModel>;

    public function new(?gestureController:GestureController)
    {
        super();

        this.allowSelection = false;

        this.gestureController = gestureController;
        this.gestureController.onGestureAdded.add(populate);

        populate();
    }

    private function populate()
    {
        dataSource.removeAll();

        this.gestures = gestureController.getGestureModels();

        var pos:Int = 0;
        for(gesture in gestures)
        {
            dataSource.add(
                {
                    text: gesture.name,
                    componentType: "button",
                    componentValue: "delete"
                }
            );
            var item:CustomComponentRenderer = cast(getItem(pos++), CustomComponentRenderer);
            item.component.onClick = function(e) {
                deleteGesture(gesture);
            };
        }
    }

    private function deleteGesture(gestureModel:GestureModel)
    {
        gestureController.deleteGesture(gestureModel);
        populate();
    }
}