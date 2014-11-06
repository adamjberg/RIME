package filters;

class Filter {

    private var values:Array<Float>;

    public function new()
    {
        reset();   
    }

    public function reset()
    {
        values = new Array<Float>();
    }

    public function update(newValues:Array<Float>):Array<Float>
    {
        return newValues;
    }
}