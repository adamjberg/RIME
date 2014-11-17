package gestures.models;

import sys.io.FileInput;
import sys.io.FileOutput;
import utils.ArrayUtils;

/**
 * This class implements a quantization component. In this case a
 * k-mean-algorithm is used. In this case the initial values of the algorithm
 * are ordered as two intersected circles, representing an abstract globe with
 * k=14 elements. As a special feature the radius of this globe would be
 * calculated dynamically before the training of this component.
 */
class Quantizer {
    private var radius:Float;
    private var numStates:Int;
    private var centeroids:Array<Array<Float>>;
    private var areCenteroidsTrained:Bool;

    /**
     * Initialize a empty quantizer. The states variable is necessary since some
     * algorithms need this value to calculate their values correctly.
     *
     */
    public function new(numStates:Int)
    {
        this.numStates = numStates;
        centeroids = new Array<Array<Float>>();
        ArrayUtils.init2DFloatArray(centeroids, 14);
        areCenteroidsTrained = false;
    }

    /**
     * Trains this Quantizer with a specific gesture. This means that the
     * positions of the centeroids would adapt to this training gesture. In our
     * case this would happen with a summarized virtual gesture, containing all
     * the other gestures.
     */
    public function trainCenteroids(gesture:Gesture)
    {
        var data:Array<Array<Float>> = gesture.getData();
        var pi:Float = Math.PI;
        radius = (gesture.getMax() + gesture.getMin()) / 2;

        // x , z , y
        if (!areCenteroidsTrained)
        {
            areCenteroidsTrained = true;
            centeroids[0] = [ radius, 0.0, 0.0 ];
            centeroids[1] = [ Math.cos(pi / 4) * radius, 0.0,
                    Math.sin(pi / 4) * radius ];
            centeroids[2] = [ 0.0, 0.0, radius ];
            centeroids[3] = [ Math.cos(pi * 3 / 4) * radius,
                    0.0, Math.sin(pi * 3 / 4) * radius ];
            centeroids[4] = [ -radius, 0.0, 0.0 ];
            centeroids[5] = [ Math.cos(pi * 5 / 4) * radius,
                    0.0, Math.sin(pi * 5 / 4) * radius ];
            centeroids[6] = [ 0.0, 0.0, -radius ];
            centeroids[7] = [ Math.cos(pi * 7 / 4) * radius,
                    0.0, Math.sin(pi * 7 / 4) * radius ];

            centeroids[8] = [ 0.0, radius, 0.0 ];
            centeroids[9] = [ 0.0, Math.cos(pi / 4) * radius,
                    Math.sin(pi / 4) * radius ];
            centeroids[10] = [ 0.0,
                    Math.cos(pi * 3 / 4) * radius,
                    Math.sin(pi * 3 / 4) * radius ];
            centeroids[11] = [ 0.0, -radius, 0.0 ];
            centeroids[12] = [ 0.0,
                    Math.cos(pi * 5 / 4) * radius,
                    Math.sin(pi * 5 / 4) * radius ];
            centeroids[13] = [ 0.0,
                    Math.cos(pi * 7 / 4) * radius,
                    Math.sin(pi * 7 / 4) * radius ];
        }

        var g_alt:Array<Array<Int>> = new Array<Array<Int>>();
        var g:Array<Array<Int>> = new Array<Array<Int>>();

        do {
            // Derive new Groups...
            g_alt = this.copyarray(g);
            g = deriveGroups(gesture);

            // calculate new centeroids
            for (i in 0...centeroids.length)
            {
                var countX : Float = 0;
                var countY : Float = 0;
                var countZ:Float = 0;
                var denominator:Int = 0;
                for (j in 0...data.length)
                {
                    if (g[i][j] == 1)
                    {
                        countX += data[j][0];
                        countY += data[j][1];
                        countZ += data[j][2];
                        denominator++;
                    }
                }
                if (denominator > 1)
                {
                    centeroids[i] = [
                        (countX / denominator),
                        (countY / denominator),
                        (countZ / denominator)
                    ];
                }
            } // new centeroids

        } while (!equalarrays(g_alt, g));
    }

    /**
     * This methods looks up a Gesture to a group matrix, used by the
     * k-mean-algorithm (traincenteroid method) above.
     */
    public function deriveGroups(gesture:Gesture):Array<Array<Int>>
    {
        var data:Array<Array<Float>> = gesture.getData();
        var groups:Array<Array<Int>> = new Array<Array<Int>>();
        ArrayUtils.init2DIntArray(groups, centeroids.length);

        // Calculate cartesian distance
        var d:Array<Array<Float>> = new Array<Array<Float>>();
        ArrayUtils.init2DFloatArray(d, centeroids.length);

        var curr:Array<Float> = new Array<Float>();
        var vector:Array<Float> = new Array<Float>();
        for (i in 0...centeroids.length) {
            var ref:Array<Float> = centeroids[i];
            for (j in 0...data.length) {

                curr[0] = data[j][0];
                curr[1] = data[j][1];
                curr[2] = data[j][2];

                vector[0] = ref[0] - curr[0];
                vector[1] = ref[1] - curr[1];
                vector[2] = ref[2] - curr[2];
                d[i][j] = Math.sqrt((vector[0] * vector[0])
                        + (vector[1] * vector[1]) + (vector[2] * vector[2]));
            }
        }

        // look, to which group a value belongs
        for (j in 0...data.length) {
            var smallest:Float = Math.POSITIVE_INFINITY;
            var row:Int = 0;
            for (i in 0...centeroids.length)
            {
                if (d[i][j] < smallest)
                {
                    smallest = d[i][j];
                    row = i;
                }
                groups[i][j] = 0;
            }
            groups[row][j] = 1;
        }

        return groups;

    }

    /**
     * With this method you can transform a gesture to a discrete symbol
     * sequence with values between 0 and granularity (number of observations).
     */
    public function getObservationSequence(gesture:Gesture):Array<Int>
    {
        var groups:Array<Array<Int>> = deriveGroups(gesture);
        var sequence:Array<Int> = new Array<Int>();

        for (j in 0...groups[0].length)
        {
            for (i in 0...groups.length)
            {
                if (groups[i][j] == 1) {
                    sequence.push(i);
                    break;
                }
            }
        }

        // TODO: If the sequence is too short there are problems
        while (sequence.length < numStates) {
            sequence.push(sequence[sequence.length - 1]);
        }

        var out:Array<Int> = new Array<Int>();
        for (i in 0...sequence.length)
        {
            out[i] = sequence[i];
        }

        return out;
    }

    public function setUpManually(centeroids:Array<Array<Float>>, radius:Float) {
        this.centeroids = centeroids;
        this.radius = radius;
    }

    public function printMap() {
        trace("Centeroids: " + centeroids);
    }

    public function writeToFile(file:FileOutput)
    {
        file.writeInt8(numStates);
        file.writeDouble(radius);

        for(i in 0...centeroids.length)
        {
            for(j in 0...centeroids[i].length)
            {
                file.writeDouble(centeroids[i][j]);
            }
        }
    }

    public static function fromFile(file:FileInput):Quantizer
    {
        var numStates = file.readInt8();
        trace("Quantizer:fromFile numStates " + numStates);

        var result:Quantizer = new Quantizer(numStates);
        result.radius = file.readDouble();
        trace("Quantizer:fromFile radius " + result.radius);

        var centeroidsLength:Int = 14;
        var centeroidsInnerLength:Int = 3;

        for(i in 0...centeroidsLength)
        {
            for(j in 0...centeroidsInnerLength)
            {
                result.centeroids[i][j] = file.readDouble();
            }
        }

        result.areCenteroidsTrained = true;

        return result;
    }

    private function copyarray(oldArr:Array<Array<Int>>):Array<Array<Int>> {
        var newArr:Array<Array<Int>> = new Array<Array<Int>>();
        ArrayUtils.init2DIntArray(newArr, oldArr.length);
        for (i in 0...oldArr.length)
        {
            for (j in 0...oldArr[i].length)
            {
                newArr[i][j] = oldArr[i][j];
            }
        }
        return newArr;
    }

    private function equalarrays(one:Array<Array<Int>>, two:Array<Array<Int>>):Bool
    {
        for (i in 0...one.length)
        {
            for (j in 0...one[i].length)
            {
                if (!(one[i][j] == two[i][j]))
                {
                    return false;
                }
            }
        }
        return true;
    }
}
