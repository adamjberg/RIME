package;

import filters.SimpleLowPassFilter;
import models.sensors.Accelerometer;
import openfl.display.Sprite;
import gestures.models.*;
import filters.*;
import gestures.controllers.GestureController;
import openfl.events.MouseEvent;

class Main extends Sprite {

    private var controller:GestureController;

	public function new () {
        super();
        
        var accel:Accelerometer = new Accelerometer();
        accel.addFilter(new SimpleLowPassFilter(), 0);
        accel.addFilter(new SimpleLowPassFilter(), 1);
        accel.addFilter(new SimpleLowPassFilter(), 2);
        controller = new GestureController(accel, stage);
        stage.addEventListener(MouseEvent.MOUSE_DOWN, down);
        stage.addEventListener(MouseEvent.MOUSE_UP, up);
        stage.addEventListener(MouseEvent.RIGHT_MOUSE_UP, up2);
        stage.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, down2);
	}

    private function up(?e)
    {
        controller.stopTraining();
    }

    private function down(?e)
    {
        controller.startTraining();
    }

    private function down2(?e)
    {
        controller.startRecognizing();
    }

    private function up2(?e)
    {
        controller.stopRecognizing();
    }
}