package gestures.models;

class GestureModel {
    
    private var numStates:Int;
    private var numObservations:Int;
    private var quantizer:Quantizer;
    private var markovModel:HMM;

    // The default probability of this gesturemodel for the bayes classifier
    private var defaultProbability:Float = 0;

    // Creates a Unit (Quantizer & Model).
    public function new()
    {
        numStates = 8;
        numObservations = 14;
        markovModel = new HMM(numStates, numObservations);
        quantizer = new Quantizer(numStates);
    }

    /**
     * Trains the model to a set of motion-sequences, representing
     * different evaluations of a gesture
     */
    public function train(trainSequence:Array<Gesture>) {
        // Move all gestures into one large gesture
        var max:Float = 0;
        var min:Float = 0;
        var sum:Gesture = new Gesture();
        
        for(i in 0...trainSequence.length)
        {
            var t:Array<Array<Float>> = trainSequence[i].getData();

            // add the max and min acceleration, we later get the average
            max+=trainSequence[i].getMax();
            min+=trainSequence[i].getMin();

            for(j in 0...trainSequence[i].getData().length) {
                sum.add(t[j]);
            }
        }
        
        // get the average and set it to the sum gesture
        sum.setMaxAndMin(max/trainSequence.length, min/trainSequence.length);
        quantizer.trainCenteroids(sum);
        
        // convert gestures to a sequence of discrete values
        var seqs:Array<Array<Int>> = new Array<Array<Int>>();
        for(i in 0...trainSequence.length)
        {
            trace("adding seq");
            seqs.push(quantizer.getObservationSequence(trainSequence[i]));
        }
        
        // train the markov model with this derived discrete sequences
        markovModel.train(seqs);
        
        // set the default probability for use with the bayes classifier
        setDefaultProbabilityWithSequence(trainSequence);
    }

    /** 
     * Returns the probability that a gesture matches to this
     * gesture model.
     */
    public function matches(gesture:Gesture):Float
    {
        var sequence:Array<Int> = quantizer.getObservationSequence(gesture);
        trace("sequence: " + sequence);
        return markovModel.getProbability(sequence);
    }
    
    /**
     * Since the bayes classifier needs a model probability for
     * each model this has to be set once after training. As model
     * probability the average probability value has been choosen.
     *
     * @param defaultSequence the vector of training sequences.
     */
    private function setDefaultProbabilityWithSequence(defaultSequence:Array<Gesture>)
    {
        var prob:Float = 0;
        for(i in 0...defaultSequence.length)
        {
            prob += matches(defaultSequence[i]);
            trace("prob: " + prob);
        }
        defaultProbability= prob / defaultSequence.length;
        trace("set default: " + defaultProbability);
    }
    
    public function setDefaultProbability(prob:Float)
    {
        defaultProbability = prob;
    }

    public function getDefaultProbability():Float
    {
        return defaultProbability;
    }

    public function getQuantizer():Quantizer
    {
        return quantizer;
    }
    
    public function setQuantizer(q:Quantizer)
    {
        quantizer = q;
    }
    
    public function getHMM():HMM
    {
        return markovModel;
    }
    
    public function setHMM(hmm:HMM)
    {
        markovModel = hmm;    
    }
}
