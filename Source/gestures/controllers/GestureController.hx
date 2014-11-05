 package gestures.controllers;

import controllers.SensorController;
import gestures.models.Classifier;
import gestures.models.Gesture;
import gestures.models.GestureModel;
import models.sensors.Accelerometer;
import models.sensors.Sensor;
import msignal.Signal.Signal0;
import msignal.Signal.Signal2;
import openfl.display.Stage;
import openfl.events.MouseEvent;
import openfl.events.TimerEvent;
import openfl.utils.Timer;

 class GestureController {

    public var onGestureDetected:Signal2<Int, Float> = new Signal2<Int, Float>();
    public var onGestureAdded:Signal0 = new Signal0();

    private var currentGesture:Gesture;
    private var trainSequence:Array<Gesture> = new Array<Gesture>();
    private var classifier:Classifier;

    private var learning:Bool;
    private var analyzing:Bool;

    private var sensorController:SensorController;
    
    public function new(sensorController:SensorController)
    {
        this.sensorController = sensorController;
        this.learning = false;
        this.analyzing = false;
        this.currentGesture = new Gesture();
        this.classifier = new Classifier();
        sensorController.onSensorsUpdated.add(update);
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
            }
            else
            {
                trace("There is no data in gesture");
            }
            learning = false;
        }
    }

    public function saveGesture(gestureModel:GestureModel)
    {
        trace("Saving gesture with " + trainSequence.length + " trains");
        gestureModel.train(trainSequence);
        classifier.addGestureModel(gestureModel);
        trainSequence = new Array<Gesture>();
        onGestureAdded.dispatch();
        trace("Gesture Successfully Saved");
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

    public function getGestureModels():Array<GestureModel>
    {
        return classifier.getGestureModels();
    }

    private function fireGesture(id:Int, prob:Float)
    {
        trace("Firing Gesture: " + id + " prob: " + prob);
        onGestureDetected.dispatch(id, prob);
    }

    private function update()
    {
        var sensors:Array<Sensor> = sensorController.getEnabledSensors();
        if(this.learning || this.analyzing)
        {
            var accel:Sensor = sensors[0];
            if(accel.hasUpdatedValues)
            {
                trace("update: " + accel.getValues());
                this.currentGesture.add( accel.getValues() );
            }
        }
    }
}