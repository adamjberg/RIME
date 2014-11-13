package filters;

class SimpleLowPassFilter extends Filter {

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
        if(newValues == null)
        {
            return null;
        }
        for(i in 0...newValues.length)
        {
            values[i] = values[i] + ( newValues[i] - values[i] ) * alpha;
        }
        return values;
    }
}