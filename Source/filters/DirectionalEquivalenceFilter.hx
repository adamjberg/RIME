package filters;

class DirectionalEquivalenceFilter extends Filter {

    private static var DEFAULT_SENSITIVITY:Float = 0.2 * 9.8;

    private var sensitivity:Float = DEFAULT_SENSITIVITY;

    public function new(?sensitivity:Float)
    {
        super();
        if(sensitivity != null)
        {
            this.sensitivity = sensitivity;
        }
    }

    override public function update(newValues:Array<Float>):Array<Float>
    {
        if(newValues == null)
        {
            return null;
        }
        var directionallyEquivalent:Bool = true;
        for(i in 0...newValues.length)
        {
            if(newValues[i] < values[i] - sensitivity ||
                newValues[i] > values[i] + sensitivity)
            {
                directionallyEquivalent = false;
            }
        }

        if(directionallyEquivalent == false)
        {
            values = newValues.copy();
        }

        return values;
    }
}