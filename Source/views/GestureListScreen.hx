package views;

import controllers.Client;
import controllers.ScreenManager;
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
import views.GestureList;

class GestureListScreen extends VBox {

    private var gestureList:GestureList;

    private var gestureController:GestureController;
    private var addGestureButton:Button;

    public function new(?gestureController:GestureController)
    {
        super();

        this.gestureController = gestureController;

        this.percentWidth = 100;
        this.percentHeight = 100;

        gestureList = new GestureList(gestureController);
        addChild(gestureList);

        addGestureButton = new Button();
        addGestureButton.text = "Add Gesture";
        addGestureButton.percentWidth = 100;
        addGestureButton.onClick = addGestureButtonClicked;
        addChild(addGestureButton); 
    }

    private function addGestureButtonClicked(e)
    {
        ScreenManager.push(new GestureEditScreen(gestureController));
    }
}