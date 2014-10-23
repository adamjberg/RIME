package filters;

class SimpleLowPassFilter extends Filter {

    private static var DEFAULT_ALPHA:Float = 0.8;

    private var alpha:Float = DEFAULT_ALPHA;
    private var value:Float = 0;

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
        value = value + ( newValue - value ) * alpha;
        return value;
    }
}