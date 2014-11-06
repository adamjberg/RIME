package filters;

class IdleStateFilter extends Filter {

    private static var DEFAULT_SENSITIVITY:Float = 1;
    private static var DEFAULT_REST_VALUE:Float = 0;

    private var restValue:Float = DEFAULT_REST_VALUE;
    private var sensitivity:Float = DEFAULT_SENSITIVITY;

    public function new(?restValue:Float, ?sensitivity:Float)
    {
        super();
        if(sensitivity != null)
        {
            this.sensitivity = sensitivity;
        }
        if(restValue != null)
        {
            this.restValue = restValue;
        }
    }

    // Only return the new value if it is outside the sensitivity range
    override public function update(newValue:Float):Float
    {
        if(newValue > restValue + sensitivity ||
            newValue < restValue - sensitivity)
        {
            value = newValue;
            return value;
        }
        return Math.NaN;
    }
}