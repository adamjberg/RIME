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
import msignal.Signal.Signal1;
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

    public var onGestureDetected:Signal1<GestureModel> = new Signal1<GestureModel>();
    public var onGestureAdded:Signal0 = new Signal0();

    private var currentGesture:Gesture;
    private var trainSequence:Array<Gesture> = new Array<Gesture>();
    private var classifier:Classifier;
    private var gestureModels:Array<GestureModel>;

    private var learning:Bool;
    private var analyzing:Bool;
    private var noButtonDetectionEnabled:Bool = false;

    private var sensorDataController:SensorDataController;
    private var linearAccelFilteredData:FilteredSensorData;
    
    public function new(sensorDataController:SensorDataController)
    {
        this.sensorDataController = sensorDataController;
        this.learning = false;
        this.analyzing = false;
        this.currentGesture = new Gesture();
        this.classifier = new Classifier();
        this.gestureModels = new Array<GestureModel>();

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

    public function enableNoButtonTraining()
    {
        if(linearAccelFilteredData != null)
        {
            var changeDetectFilter:ChangeDetectFilter = cast(linearAccelFilteredData.getFilter(ChangeDetectFilter), ChangeDetectFilter);
            changeDetectFilter.onChangeStarted.add(startTraining);
            changeDetectFilter.onChangeStopped.add(stopTraining);
        }
    }

    public function disableNoButtonTraining()
    {
        if(linearAccelFilteredData != null)
        {
            var changeDetectFilter:ChangeDetectFilter = cast(linearAccelFilteredData.getFilter(ChangeDetectFilter), ChangeDetectFilter);
            changeDetectFilter.onChangeStarted.remove(startTraining);
            changeDetectFilter.onChangeStopped.remove(stopTraining);
        }
    }

    public function enableNoButtonDetection()
    {
        if(linearAccelFilteredData != null && noButtonDetectionEnabled == false)
        {
            var changeDetectFilter:ChangeDetectFilter = cast(linearAccelFilteredData.getFilter(ChangeDetectFilter), ChangeDetectFilter);
            changeDetectFilter.onChangeStarted.add(startRecognizing);
            changeDetectFilter.onChangeStopped.add(stopRecognizing);
            noButtonDetectionEnabled = true;
        }
    }

    public function disableNoButtonDetection()
    {
        if(linearAccelFilteredData != null && noButtonDetectionEnabled)
        {
            var changeDetectFilter:ChangeDetectFilter = cast(linearAccelFilteredData.getFilter(ChangeDetectFilter), ChangeDetectFilter);
            changeDetectFilter.onChangeStarted.remove(startRecognizing);
            changeDetectFilter.onChangeStopped.remove(stopRecognizing);
            noButtonDetectionEnabled = false;
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
            if(currentGesture.getCountOfData() > MIN_VALUES_BEFORE_RECOGNITION)
            {
                trace("Recorded " + currentGesture.getCountOfData() + " values");
                var gesture:Gesture = new Gesture(currentGesture);
                trainSequence.push(gesture);
                currentGesture = new Gesture();
                Haptic.vibrate(0, 250);
            }
            else
            {
                trace("There is no data in gesture");
            }
            learning = false;
        }
    }

    public function clearCurrentGesture()
    {
        trainSequence = new Array<Gesture>();
    }

    public function saveGesture(gestureModel:GestureModel)
    {
        trace("Saving gesture with " + trainSequence.length + " trains");
        gestureModel.train(trainSequence);
        gestureModels.push(gestureModel);
        trainSequence = new Array<Gesture>();
        writeGesturesToFile();
        onGestureAdded.dispatch();
        trace("Gesture Successfully Saved");
    }

    public function deleteGesture(gestureModel:GestureModel)
    {
        gestureModels.remove(gestureModel);
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

    public function getGestureModelByName(gestureName:String):GestureModel
    {
        for(gestureModel in gestureModels)
        {
            if(gestureModel.name == gestureName)
            {
                return gestureModel;
            }
        }
        return null;
    }

    /*
     * Enable a gesture, if we are enabling a gesture we most likely
     * want no button detection on as well
     */
    public function enableGesture(gestureModel:GestureModel)
    {
        enableNoButtonDetection();
        classifier.addGestureModel(gestureModel);
    }

    /*
     * Removes all active gestures, and stops the detection
     */
    public function disableAllGestures()
    {
        disableNoButtonDetection();
        classifier.clear();
    }

    public function getGestureModels():Array<GestureModel>
    {
        return gestureModels;
    }

    private function fireGesture(id:Int, prob:Float)
    {
        var gestureModel:GestureModel = classifier.getGestureModels()[id];

        Haptic.vibrate(0, 250);
        PopupManager.instance.showBusy(gestureModel.name, 500, "Gesture Detected!");

        trace("Firing Gesture: " + gestureModel.name + " prob: " + prob);
        onGestureDetected.dispatch(gestureModel);
    }

    private function update(newValues:Array<Float>)
    {
        if(this.learning || this.analyzing)
        {
            this.currentGesture.add( newValues );
        }
    }

    public function loadGesturesFromFile()
    {
        if(FileSystem.exists(FULL_FILENAME))
        {
            var file:FileInput = File.read(FULL_FILENAME, true);
            var numGestures:Int = file.readInt8();
            for(i in 0...numGestures)
            {
                gestureModels.push
                (
                    GestureModel.fromFile(file)
                );
            }
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
        file.writeInt8(gestureModels.length);
        for(gestureModel in gestureModels)
        {
            gestureModel.writeToFile(file);
        }
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