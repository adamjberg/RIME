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

    override public function update(newValue:Float):Float
    {
        var prevValue = value + ( newValue - value ) * alpha;
        value = newValue - prevValue;
        return value;
    }
}