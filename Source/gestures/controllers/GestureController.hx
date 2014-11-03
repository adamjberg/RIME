 package gestures.controllers;

import gestures.models.Classifier;
import gestures.models.Gesture;
import gestures.models.GestureModel;
import models.sensors.Accelerometer;
import msignal.Signal.Signal2;
import openfl.display.Stage;
import openfl.events.MouseEvent;
import openfl.events.TimerEvent;
import openfl.utils.Timer;

 class GestureController {

    private static var UPDATE_FREQ_MS:Float = 100;

    public var onGestureDetected:Signal2<Int, Float> = new Signal2<Int, Float>();

    private var currentGesture:Gesture;
    private var trainSequence:Array<Gesture> = new Array<Gesture>();
    private var classifier:Classifier;

    private var learning:Bool;
    private var analyzing:Bool;

    private var updateTimer:Timer;

    // For testing only
    private var accel:Accelerometer;
    private var stage:Stage;

    public function new(accel:Accelerometer, stage:Stage)
    {
        this.accel = accel;
        this.learning = false;
        this.analyzing = false;
        this.currentGesture = new Gesture();
        this.classifier = new Classifier();
        updateTimer = new Timer(UPDATE_FREQ_MS, 0);
        updateTimer.addEventListener(TimerEvent.TIMER, update);
        updateTimer.start();
        this.stage = stage;
        stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);

    }

    public function startTraining()
    {
        if(!analyzing && !learning)
        {
            trace("Training Started");
            learning = true;
        }
    }

    public function stopTraining()
    {
        if(learning)
        {
            trace("Training Stopped");
            if(currentGesture.getCountOfData() > 0)
            {
                trace("Recorded " + currentGesture.getCountOfData() + " values");
                var gesture:Gesture = new Gesture(currentGesture);
                trainSequence.push(gesture);
                currentGesture = new Gesture();
                var gestureModel:GestureModel = new GestureModel();
                gestureModel.train(trainSequence);
                classifier.addGestureModel(gestureModel);

                trainSequence = new Array<Gesture>();
            }
            else
            {
                trace("There is no data in gesture");
            }
            learning = false;
        }
    }

    public function startRecognizing()
    {
        if(!analyzing && !learning)
        {
            trace("Starting Recognition");
            analyzing = true;
        }
    }

    public function stopRecognizing()
    {
        if(analyzing)
        {
            trace("Stopping Recognition");
            if(currentGesture.getCountOfData() > 0)
            {
                trace("Comparing gesture with " + classifier.getCountOfGestures() + " other gestures");
                var gesture:Gesture = new Gesture(currentGesture);
                currentGesture = new Gesture();

                var recognized:Int = this.classifier.classifyGesture(gesture);
                if(recognized != -1)
                {
                    var prob:Float = classifier.getLastProbability();
                    fireGesture(recognized, prob);
                }
                else
                {
                    trace("No suitable gesture match found");
                }
            }
        }
        analyzing = false;
    }

    private function fireGesture(id:Int, prob:Float)
    {
        trace("Firing Gesture: " + id + " prob: " + prob);
        onGestureDetected.dispatch(id, prob);
    }


    private var mouseX:Float = 0;
    private var mouseY:Float = 0;
    private function mouseMove(e:MouseEvent)
    {
        mouseX = e.stageX / stage.stageWidth;
        mouseY = e.stageY / stage.stageHeight;
    }

    private function update(?e:TimerEvent)
    {
        if(this.learning || this.analyzing)
        {
            var array:Array<Float> = [
                mouseX,
                mouseY,
                0,
            ];
            trace("update: " + array);
            this.currentGesture.add( array );
        }
    }
}