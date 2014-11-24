 package gestures.controllers;

import controllers.SensorController;
import controllers.SensorDataController;
import filters.ChangeDetectFilter;
import filters.Filter;
import gestures.models.Classifier;
import gestures.models.Gesture;
import gestures.models.GestureModel;
import haxe.ui.toolkit.core.PopupManager;
import models.sensors.Accelerometer;
import models.sensors.data.FilteredSensorData;
import models.sensors.LinearAccelerometer;
import models.sensors.Sensor;
import msignal.Signal.Signal0;
import msignal.Signal.Signal2;
import openfl.display.Stage;
import openfl.events.MouseEvent;
import openfl.events.TimerEvent;
import openfl.feedback.Haptic;
import openfl.utils.SystemPath;
import openfl.utils.Timer;
import sys.FileSystem;
import sys.io.File;
import sys.io.FileInput;
import sys.io.FileOutput;

 class GestureController {

    private static var MIN_VALUES_BEFORE_RECOGNITION:Int = 8;

    private static var DIRECTORY:String = SystemPath.applicationStorageDirectory + "/gestures";
    private static var FILENAME:String = "gestures.rime";
    private static var FULL_FILENAME:String = DIRECTORY + "/" + FILENAME;

    public var onGestureDetected:Signal2<Int, Float> = new Signal2<Int, Float>();
    public var onGestureAdded:Signal0 = new Signal0();

    private var currentGesture:Gesture;
    private var trainSequence:Array<Gesture> = new Array<Gesture>();
    private var classifier:Classifier;

    private var learning:Bool;
    private var analyzing:Bool;

    private var sensorDataController:SensorDataController;
    private var linearAccelFilteredData:FilteredSensorData;
    
    public function new(sensorDataController:SensorDataController)
    {
        this.sensorDataController = sensorDataController;
        this.learning = false;
        this.analyzing = false;
        this.currentGesture = new Gesture();
        this.classifier = new Classifier();

        loadGesturesFromFile();

        setupGesturesDirectory();

        linearAccelFilteredData = sensorDataController.getFilteredWithName(LinearAccelerometer.NAME);
        if(linearAccelFilteredData != null)
        {
            linearAccelFilteredData.onUpdate.add(update);
        }
        else
        {
            trace("Can't find Linear Accelerometer");
        }
    }

    public function enableNoButtonDetection()
    {
        if(linearAccelFilteredData != null)
        {
            var changeDetectFilter:ChangeDetectFilter = cast(linearAccelFilteredData.getFilter(ChangeDetectFilter), ChangeDetectFilter);
            changeDetectFilter.onChangeStarted.add(startRecognizing);
            changeDetectFilter.onChangeStopped.add(stopRecognizing);
        }
    }

    public function disableNoButtonDetection()
    {
        if(linearAccelFilteredData != null)
        {
            var changeDetectFilter:ChangeDetectFilter = cast(linearAccelFilteredData.getFilter(ChangeDetectFilter), ChangeDetectFilter);
            changeDetectFilter.onChangeStarted.remove(startRecognizing);
            changeDetectFilter.onChangeStopped.remove(stopRecognizing);
        }
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
        writeGesturesToFile();
        onGestureAdded.dispatch();
        trace("Gesture Successfully Saved");
    }

    public function deleteGesture(gestureModel:GestureModel)
    {
        classifier.deleteGesture(gestureModel);
        writeGesturesToFile();
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
            if(currentGesture.getCountOfData() > MIN_VALUES_BEFORE_RECOGNITION)
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
        var gestureModel:GestureModel = getGestureModels()[id];

        Haptic.vibrate(0, 250);
        PopupManager.instance.showBusy(gestureModel.name, 500, "Gesture Detected!");

        trace("Firing Gesture: " + gestureModel.name + " prob: " + prob);
        onGestureDetected.dispatch(id, prob);
    }

    private function update(newValues:Array<Float>)
    {
        if(this.learning || this.analyzing)
        {
            trace("update: " + newValues);
            this.currentGesture.add( newValues );
        }
    }

    public function loadGesturesFromFile()
    {
        if(FileSystem.exists(FULL_FILENAME))
        {
            var file:FileInput = File.read(FULL_FILENAME, true);
            classifier = Classifier.fromFile(file);
            file.close();
        }
    }

    public function writeGesturesToFile()
    {
        if(FileSystem.exists(FULL_FILENAME))
        {
            FileSystem.deleteFile(FULL_FILENAME);
        }

        var file:FileOutput = File.write(FULL_FILENAME, true);
        classifier.writeToFile(file);
        file.close();
    }

    private function setupGesturesDirectory()
    {
        if(!FileSystem.exists(DIRECTORY))
        {
            FileSystem.createDirectory(DIRECTORY);
        }
    }
}