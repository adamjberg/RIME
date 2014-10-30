 package gestures.controllers;

import gestures.models.Classifier;
import gestures.models.Gesture;
import gestures.models.GestureModel;
import models.sensors.Accelerometer;
import msignal.Signal.Signal2;
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

    public function new(accel:Accelerometer)
    {
        this.accel = accel;
        this.learning = false;
        this.analyzing = false;
        this.currentGesture = new Gesture();
        this.classifier = new Classifier();
        updateTimer = new Timer(UPDATE_FREQ_MS, 0);
        updateTimer.addEventListener(TimerEvent.TIMER, update);
        updateTimer.start();
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

    private function update(?e:TimerEvent)
    {
        accel.update();
        if(this.learning || this.analyzing)
        {
            trace("update: " + accel.values);
            this.currentGesture.add( accel.values );
        }
    }
}