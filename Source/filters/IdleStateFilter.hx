package filters;

class IdleStateFilter extends Filter {

    private static var DEFAULT_SENSITIVITY:Float = 0.1;
    private static var DEAFULT_REST_VALUE:Float = 1;

    private var restValue:Float = DEAFULT_REST_VALUE;
    private var sensitivity:Float;

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
            return value;
        }
        return null;
    }
}