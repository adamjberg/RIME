package gestures.models;

class Classifier
	{

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
            trace("i: " + i);
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
                trace("tmpmodel " + tmpmodel);
                trace("tmpgesture " + tmpgesture);
                trace("sum: " + sum);
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
}