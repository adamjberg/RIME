package views;

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
import openfl.events.MouseEvent;
import osc.OscMessage;
import views.controls.LabelledTextInput;

class GestureEditScreen extends VBox {

    private static var EDIT_MODE:Int = 0;
    private static var CREATE_MODE:Int = 1;

    private var mode:Int;

    private var nameInput:LabelledTextInput;
    private var recordButton:Button;
    private var recognizeButton:Button;
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

        nameInput = new LabelledTextInput("name:");
        nameInput.horizontalAlign = "center";
        addChild(nameInput);

        saveGestureButton = new Button();
        saveGestureButton.percentWidth = 100;
        saveGestureButton.percentHeight = 33;
        saveGestureButton.text = "Save Gesture";
        saveGestureButton.onClick = saveGesture;
        addChild(saveGestureButton);

        recordButton = new Button();
        recordButton.percentWidth = 100;
        recordButton.percentHeight = 33;
        recordButton.text = "Record";
        recordButton.addEventListener(MouseEvent.MOUSE_DOWN, recordDown);
        recordButton.addEventListener(MouseEvent.MOUSE_UP, recordUp);
        addChild(recordButton);
    }

    private function recordDown(?e:MouseEvent)
    {
        gestureController.startTraining();
    }

    private function recordUp(?e:MouseEvent)
    {
        gestureController.stopTraining();
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