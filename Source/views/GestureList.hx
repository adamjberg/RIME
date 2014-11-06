package views;

import controllers.ScreenManager;
import gestures.controllers.GestureController;
import gestures.models.GestureModel;
import haxe.ui.toolkit.containers.VBox;
import haxe.ui.toolkit.containers.ScrollView;
import haxe.ui.toolkit.controls.Button;
import haxe.ui.toolkit.controls.Text;
import views.GestureEditScreen;
import views.GestureListItem;

class GestureList extends ScrollView {

    private var gestureController:GestureController;
    private var gestures:Array<GestureModel>;
    private var vBox:VBox;

    public function new(?gestureController:GestureController)
    {
        super();

        this.gestureController = gestureController;

        this.style.borderSize = 0;
        this.style.spacingY = 10;

        this.percentWidth = 95;
        this.percentHeight = 40;
        this.horizontalAlign = "center";
        
        vBox = new VBox();
        vBox.percentWidth = 100;
        addChild(vBox);

        this.gestureController.onGestureAdded.add(populate);
        populate();
    }

    private function populate()
    {
        vBox.removeAllChildren();

        this.gestures = gestureController.getGestureModels();
        for(gesture in gestures)
        {
            var gestureListItem:GestureListItem = new GestureListItem(gesture);
            gestureListItem.onDeleteButtonPressed.add(deleteGesture);
            vBox.addChild(gestureListItem);
        }
    }

    private function deleteGesture(gestureModel:GestureModel)
    {
        gestureController.deleteGesture(gestureModel);
        populate();
    }
}