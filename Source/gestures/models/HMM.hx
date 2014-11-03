package gestures.models;

import utils.ArrayUtils;

/**
 * This is a Hidden Markov Model implementation which internally provides
 * the basic algorithms for training and recognition (forward and backward
 * algorithm). Since a regular Hidden Markov Model doesn't provide a possibility
 * to train multiple sequences, this implementation has been optimized for this
 * purposes using some state-of-the-art technologies described in several papers.
 *
 */

class HMM {
    public var numStates:Int;
    public var numObservations:Int;
    public var initialProbabilitiesForState:Array<Float>;

    /** The state change probability to switch from state A to
     * state B: a[stateA][stateB] */
    public var a:Array<Array<Float>>;

    /** The probability to emit symbol S in state A: b[stateA][symbolS] */
    public var b:Array<Array<Float>>;

    public function new(numStates:Int, numObservations:Int)
    {
        this.numStates = numStates;
        this.numObservations = numObservations;
        initialProbabilitiesForState = new Array<Float>();
        a = new Array<Array<Float>>();
        ArrayUtils.init2DFloatArray(a, numStates);
        b = new Array<Array<Float>>();
        ArrayUtils.init2DFloatArray(b, numStates);
        reset();
    }
    
    private function reset()
    {
        var jumplimit:Int = 2;
        
        // set startup probability
        initialProbabilitiesForState[0] = 1;
        for(i in 1...numStates)
        {
            initialProbabilitiesForState[i] = 0;
        }
        
        // TODO: Clean up
        for(i in 0...numStates)
        {
            for(j in 0...numStates)
            {
                if(i==numStates-1 && j==numStates-1) { // last row
                    a[i][j] = 1.0;
                } else if(i==numStates-2 && j==numStates-2) { // next to last row
                    a[i][j] = 0.5;
                } else if(i==numStates-2 && j==numStates-1) { // next to last row
                    a[i][j] = 0.5;
                } else if(i<=j && i>j-jumplimit-1) {
                    a[i][j] = 1.0/(jumplimit+1);
                } else {
                    a[i][j] = 0.0;
                }
            }
        }        
        // emission probability
        for(i in 0...numStates) {
            for(j in 0...numObservations)
            {
                b[i][j] = 1.0 / numObservations;

            }
        }
    }

    /**
     * Trains the Hidden Markov Model with multiple sequences.
     * This method is normally not known to basic hidden markov
     * models, because they usually use the Baum-Welch-Algorithm.
     * This method is NOT the traditional Baum-Welch-Algorithm.
     * 
     * If you want to know in detail how it works please consider
     * my Individuelles Projekt paper on the wiigee Homepage. Also
     * there exist some english literature on the world wide web.
     * Try to search for some papers by Rabiner or have a look at
     * Vesa-Matti Mäntylä - "Discrete Hidden Markov Models with
     * application to isolated user-dependent hand gesture recognition". 
     * 
     */
    public function train(trainsequence:Array<Array<Int>>) {

        var a_new:Array<Array<Float>> = new Array<Array<Float>>();
        ArrayUtils.init2DFloatArray(a_new, a.length);
        var b_new:Array<Array<Float>> = new Array<Array<Float>>();
        ArrayUtils.init2DFloatArray(b_new, b.length);
        // re calculate state change probability a
        for(i in 0...a.length)
        {
            for(j in 0...a[i].length)
            {
                var count:Float = 0;
                var denominator:Float = 0;
            
                for(k in 0...trainsequence.length)
                {
                    var sequence:Array<Int> = trainsequence[k];
                    
                    var fwd:Array<Array<Float>> = forwardProc(sequence);
                    var bwd:Array<Array<Float>> = backwardProc(sequence);
                    var prob:Float = getProbability(sequence);

                    var count_innersum:Float = 0;
                    var denominator_innersum:Float = 0;
                    
                    for(t in 0...sequence.length-1)
                    {
                        count_innersum += fwd[i][t]*a[i][j]*b[j][sequence[t+1]]*bwd[j][t+1];
                        denominator_innersum += fwd[i][t]*bwd[i][t];
                    }
                    count += (1/prob) * count_innersum;
                    denominator += (1/prob) * denominator_innersum;
                } // k
                a_new[i][j] = count / denominator;
                if(Math.isNaN(a_new[i][j]))
                {
                    a_new[i][j] = 0;
                }
            } // j
        } // i
        
        // re calculate emission probability b
        for(i in 0...b.length) { // zustaende
            for(j in 0...b[i].length)
            {  // symbole
                var count:Float = 0;
                var denominator:Float = 0;
            
                for(k in 0...trainsequence.length) 
                {
                    var sequence:Array<Int> = trainsequence[k];
                    
                    var fwd:Array<Array<Float>> = forwardProc(sequence);
                    var bwd:Array<Array<Float>> = backwardProc(sequence);
                    var prob:Float = getProbability(sequence);
        
                    var count_innersum:Float = 0;
                    var denominator_innersum:Float = 0;
                    
                    
                    for(t in 0...sequence.length-1)
                    {
                        if(sequence[t]==j) {
                            count_innersum+=fwd[i][t]*bwd[i][t];
                        }
                        denominator_innersum+=fwd[i][t]*bwd[i][t];
                    }
                    count += (1/prob)*count_innersum;
                    denominator += (1/prob)*denominator_innersum;
                } // k
        
                b_new[i][j] = count / denominator;
                if(Math.isNaN(b_new[i][j]))
                {
                    b_new[i][j] = 0;
                }
            } // j
        } // i
    
        a = a_new;
        b = b_new;
    }
    
    /**
     * Traditional Forward Algorithm.
     * 
     * @param o the observationsequence O
     * @return Array[State][Time] 
     * 
     */
    private function forwardProc(o:Array<Int>):Array<Array<Float>>
    {
        var f:Array<Array<Float>> = new Array<Array<Float>>();
        ArrayUtils.init2DFloatArray(f, numStates);
        for (l in 0...f.length)
        {
            f[l][0] = initialProbabilitiesForState[l] * b[l][o[0]];
        }
        for (i in 1...o.length)
        {
            for (k in 0...f.length)
            {
                var sum:Float = 0;
                for (l in 0...numStates)
                {
                    sum += f[l][i-1] * a[l][k];
                }
                f[k][i] = sum * b[k][o[i]];
            }
        }
        return f;
    }
    
    /**
     * Returns the probability that a observation sequence o belongs
     * to this Hidden Markov Model without using the bayes classifier.
     * Internally the well known forward algorithm is used.
     * 
     * @param o observation sequence
     * @return probability that sequence o belongs to this hmm
     */
    public function getProbability(o:Array<Int>):Float
    {
        var prob:Float = 0;
        var forward:Array<Array<Float>> = forwardProc(o);
        //  add probabilities
        for (i in 0...forward.length)
        { // for every state
            prob += forward[i][forward[i].length - 1];
        }
        return prob;
    }
    
    public function print() {
        trace("HMM:print: initialProbabilitiesForState: " + initialProbabilitiesForState);
        trace("HMM:print: a: " + a);
        trace("HMM:print: b: " + b);
    }

    /**
     * Backward algorithm.
     * 
     * @param o observation sequence o
     * @return Array[State][Time]
     */
    private function backwardProc(o:Array<Int>):Array<Array<Float>> {
        var T:Int = o.length;
        var bwd:Array<Array<Float>> = new Array<Array<Float>>();
        ArrayUtils.init2DFloatArray(bwd, numStates);
        /* Basisfall */
        for (i in 0...numStates)
        {
            bwd[i][T - 1] = 1;
        }
        /* Induktion */
        var t:Int = T-2;
        while(t >= 0)
        {
            for (i in 0...numStates)
            {
                bwd[i][t] = 0;
                for (j in 0...numStates)
                {
                    bwd[i][t] += (bwd[j][t + 1] * a[i][j] * b[j][o[t + 1]]);
                }
            }
            t--;
        }
        return bwd;
    }
}
