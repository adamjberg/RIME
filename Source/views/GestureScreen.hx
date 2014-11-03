package views;

import controllers.Client;
import gestures.controllers.GestureController;
import haxe.ui.toolkit.containers.VBox;
import haxe.ui.toolkit.controls.Button;
import haxe.ui.toolkit.controls.TextInput;
import haxe.ui.toolkit.events.UIEvent;
import models.commands.ViperCreateImageCommand;
import models.commands.ViperUpdatePositionCommand;
import models.sensors.Accelerometer;
import openfl.events.MouseEvent;
import osc.OscMessage;

class GestureScreen extends VBox {

    private var recordButton:Button;
    private var recognizeButton:Button;
    private var saveGestureButton:Button;

    private var gestureController:GestureController;

    public function new(?gestureController:GestureController)
    {
        super();

        this.gestureController = gestureController;

        this.percentWidth = 100;
        this.percentHeight = 100;

        recordButton = new Button();
        recordButton.percentWidth = 100;
        recordButton.percentHeight = 33;
        recordButton.text = "Record";
        recordButton.addEventListener(MouseEvent.MOUSE_DOWN, recordDown);
        recordButton.addEventListener(MouseEvent.MOUSE_UP, recordUp);
        addChild(recordButton);

        recognizeButton = new Button();
        recognizeButton.percentWidth = 100;
        recognizeButton.percentHeight = 33;
        recognizeButton.text = "Recognize";
        recognizeButton.addEventListener(MouseEvent.MOUSE_DOWN, recognizeDown);
        recognizeButton.addEventListener(MouseEvent.MOUSE_UP, recognizeUp);
        addChild(recognizeButton);

        saveGestureButton = new Button();
        saveGestureButton.percentWidth = 100;
        saveGestureButton.percentHeight = 33;
        saveGestureButton.text = "Save Gesture";
        saveGestureButton.onClick = saveGesture;
        addChild(saveGestureButton);
    }

    private function recordDown(?e:MouseEvent)
    {
        gestureController.startTraining();
    }

    private function recordUp(?e:MouseEvent)
    {
        gestureController.stopTraining();
    }

    private function recognizeDown(e:MouseEvent)
    {
        gestureController.startRecognizing();
    }

    private function recognizeUp(e:MouseEvent)
    {
        gestureController.stopRecognizing();
    }

    private function saveGesture(e:UIEvent)
    {
        gestureController.saveGesture();
    }
}