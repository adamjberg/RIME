package filters;

class HighPassFilter extends Filter {

    private static var DEFAULT_ALPHA:Float = 0.8;

    private var alpha:Float = DEFAULT_ALPHA;

    public function new(?alpha:Float)
    {
        super();
        if(alpha != null)
        {
            this.alpha = alpha;
        }
    }

    override public function update(newValues:Array<Float>):Array<Float>
    {
        for(i in 0...newValues.length)
        {
            var prevValue = values[i] + ( newValues[i] - values[i] ) * ( 1 - alpha );
            values[i] = newValues[i] - prevValue[i];
        }
        return values;
    }
}