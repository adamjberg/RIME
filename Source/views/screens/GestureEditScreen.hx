package views.screens;

import controllers.Client;
import controllers.ScreenManager;
import gestures.controllers.GestureController;
import gestures.models.GestureModel;
import haxe.ui.toolkit.containers.VBox;
import haxe.ui.toolkit.controls.Button;
import haxe.ui.toolkit.controls.popups.Popup;
import haxe.ui.toolkit.core.PopupManager;
import haxe.ui.toolkit.events.UIEvent;
import models.commands.ViperCreateImageCommand;
import models.commands.ViperUpdatePositionCommand;
import models.sensors.Accelerometer;
import openfl.events.Event;
import openfl.events.MouseEvent;
import osc.OscMessage;
import views.controls.FullWidthButton;
import views.controls.LabelledTextInput;
import views.screens.Screen;

class GestureEditScreen extends Screen {

    private static var EDIT_MODE:Int = 0;
    private static var CREATE_MODE:Int = 1;

    private var mode:Int;

    private var nameInput:LabelledTextInput;
    private var recordButton:Button;
    private var recognizeButton:Button;
    private var enableNoButtonTrainingButton:FullWidthButton;
    private var saveGestureButton:Button;

    private var gestureModel:GestureModel;
    private var gestureController:GestureController;

    public function new(?gestureController:GestureController, ?gestureModel:GestureModel)
    {
        super();

        this.gestureController = gestureController;
        if(gestureModel != null)
        {
            mode = EDIT_MODE;
            this.gestureModel = gestureModel;
        }
        else
        {
            this.gestureModel = new GestureModel();
            mode = CREATE_MODE;
        }

        this.percentWidth = 100;
        this.percentHeight = 100;

        nameInput = new LabelledTextInput("Name:");
        nameInput.horizontalAlign = "center";
        addChild(nameInput);

        recordButton = new FullWidthButton("Record");
        recordButton.percentHeight = 100;
        recordButton.addEventListener(MouseEvent.MOUSE_DOWN, recordDown);
        recordButton.addEventListener(MouseEvent.MOUSE_UP, recordUp);
        addChild(recordButton);

        enableNoButtonTrainingButton = new FullWidthButton("No Button Training");
        enableNoButtonTrainingButton.toggle = true;
        enableNoButtonTrainingButton.addEventListener(UIEvent.CHANGE, noButtonTrainingButtonChanged);
        addChild(enableNoButtonTrainingButton);

        saveGestureButton = new FullWidthButton("Save Gesture");
        saveGestureButton.onClick = saveGesture;
        addChild(saveGestureButton);

        addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);

        ScreenManager.onBackPressed.addOnce(backPressed);
    }

    private function removedFromStage(?e)
    {
        ScreenManager.onBackPressed.remove(backPressed);
        gestureController.disableNoButtonTraining();
    }

    private function backPressed()
    {
        gestureController.clearCurrentGesture();
    }

    private function recordDown(?e:MouseEvent)
    {
        gestureController.startTraining();
    }

    private function recordUp(?e:MouseEvent)
    {
        gestureController.stopTraining();
    }

    private function noButtonTrainingButtonChanged(?e)
    {
        if(enableNoButtonTrainingButton.selected)
        {
            gestureController.enableNoButtonTraining();
        }
        else
        {
            gestureController.disableNoButtonTraining();
        }
    }

    private function saveGesture(e:UIEvent)
    {
        gestureModel.name = nameInput.getText();
        if(mode == CREATE_MODE)
        {
            // TODO: add some sort of popup to alert user of processing
            gestureController.saveGesture(gestureModel);
        }
        ScreenManager.pop();
    }
}