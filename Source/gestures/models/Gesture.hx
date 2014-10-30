package gestures.models;

/**
 * This class represents a movement trajectory
 */
class Gesture {

    private var minmaxmanual:Bool;
    private var min:Float;
    private var max:Float;

    private var data:Array<Array<Float>>;

    public function new(?gesture:Gesture)
    {
        this.data = new Array<Array<Float>>();
        if(gesture != null)
        {
            var origin:Array<Array<Float>> = gesture.getData();
            for (i in 0...origin.length)
            {
                add(origin[i]);
            }
        }
    }

    public function add(val:Array<Float>)
    {
        data.push(val);
    }

    public function getLastData():Array<Float>
    {
        return data[data.length - 1];
    }

    public function getData():Array<Array<Float>>
    {
        return this.data;
    }
    
    public function removeFirstData()
    {
        data.shift();
    }
    
    public function getCountOfData():Int
    {
        return data.length;
    }
    
    public function setMaxAndMin(max:Float, min:Float)
    {
        this.max = max;
        this.min = min;
        this.minmaxmanual = true;
    }
    
    public function getMax():Float
    {
        if(!this.minmaxmanual)
        {
            max = Math.NEGATIVE_INFINITY;
            for(i in 0...data.length)
            {
                for(value in data[i])
                {
                    max = Math.max(max, value);
                }
            }
        }
        return max;
    }
    
    public function getMin():Float
    {
        if(!this.minmaxmanual)
        {
            min = Math.POSITIVE_INFINITY;
            for(i in 0...data.length)
            {
                for(value in data[i])
                {
                    min = Math.min(min, value);
                }
            }
        }
        return min;
    }
}
