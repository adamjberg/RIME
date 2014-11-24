package views.screens;

import gestures.controllers.GestureController;
import haxe.ui.toolkit.controls.Text;
import openfl.events.Event;
import openfl.events.MouseEvent;
import views.screens.Screen;

class GestureRecognizeScreen extends Screen {

    private var gestureController:GestureController;
    private var helpText:Text;

    public function new(?gestureController:GestureController)
    {
        super();

        this.gestureController = gestureController;

        this.style.backgroundColor = 0xDDDDDD;

        helpText = new Text();
        helpText.text = "Press anywhere to start gesture";
        helpText.horizontalAlign = "center";
        addChild(helpText);

        addEventListener(Event.ADDED_TO_STAGE, addedToStage);
        addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
    }

    private function addedToStage(e)
    {
        gestureController.enableNoButtonDetection();
    }

    private function removedFromStage(e)
    {
        gestureController.disableNoButtonDetection();
    }

    private function startRecognize(e)
    {
        trace("start");
        gestureController.startRecognizing();
    }

    private function stopRecognize(e)
    {
        gestureController.stopRecognizing();
    }
}