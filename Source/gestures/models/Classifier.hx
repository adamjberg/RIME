package gestures.models;

import gestures.models.GestureModel;
import sys.io.File;
import sys.io.FileInput;
import sys.io.FileOutput;

class Classifier {

    private static var START_TAG:String = "classifier\n";
    private static var END_TAG:String = "\nend";

    private var gestureModels:Array<GestureModel>; 
    private var lastProbability:Float;
    
    public function new()
	{
        gestureModels = new Array<GestureModel>();
        lastProbability = 0.0;
    }
    
    /** 
     * This method recognize a specific gesture 
     * using a bayes classification algorithm is used.
     */
    public function classifyGesture(g:Gesture):Int
	{
        var sum:Float = 0;
        for(i in 0...gestureModels.length)
        {
            sum += gestureModels[i].getDefaultProbability() *
                    gestureModels[i].matches(g);
        }
        
        var recognizedGesture:Int = -1;
        var probabilityOfRecognizedGesture:Float = 0;
        var tempProbability:Float = 0;
        var tempProbModel:Float = 0;
        for(i in 0...gestureModels.length)
        {
            var tmpgesture:Float = gestureModels[i].matches(g);
            var tmpmodel:Float = gestureModels[i].getDefaultProbability();
            
            if(((tmpmodel*tmpgesture)/sum) > probabilityOfRecognizedGesture)
            {  
                tempProbability = tmpgesture;
                tempProbModel = tmpmodel;
                probabilityOfRecognizedGesture = ((tmpmodel*tmpgesture)/sum);
                recognizedGesture = i;
            }
        }
        
        // a gesture could be recognized
        if(probabilityOfRecognizedGesture > 0 && tempProbModel > 0 && tempProbability > 0 && sum > 0)
        {
            trace("Classifier: Recognized gesture: " + recognizedGesture + " prob: " + probabilityOfRecognizedGesture);
            lastProbability = probabilityOfRecognizedGesture;
            return recognizedGesture;
        }
        else
        {
            trace("Classifier:No gesture Recognized");
            return -1;
        }
        
    }
    
    public function getLastProbability():Float
	{
        return lastProbability;
    }
    
    public function addGestureModel(gm:GestureModel)
	{
        gestureModels.push(gm);
    }

    public function removeGestureModel(gm:GestureModel)
    {
        gestureModels.remove(gm);
    }

    public function getGestureModel(id:Int):GestureModel
	{
        return gestureModels[id];
    }
    
    public function getGestureModels():Array<GestureModel>
	{
        return gestureModels;
    }

    public function getCountOfGestures():Int
	{
        return gestureModels.length;
    }
    
    public function clear()
	{
        gestureModels = new Array<GestureModel>();
    }

    public function deleteGesture(gestureModel:GestureModel)
    {
        gestureModels.remove(gestureModel);
    }
}