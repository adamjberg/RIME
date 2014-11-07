package models.mappings;

class MappingParameter {

    public var method:String;
    public var name:String;
    public var maxDesired:Float;
    public var minDesired:Float;
    public var maxPossible:Float;

    public function new(method:String, name:String, minDesired:Float, maxDesired:Float, maxPossible:Float)
    {
        this.method = method;
        this.name = name;
        this.minDesired = minDesired;
        this.maxDesired = maxDesired;
        this.maxPossible = maxPossible;
    }

    public function getDesired(val:Float):Float
    {
        trace(val);
        return (val / maxPossible) * (maxDesired - minDesired) + minDesired;
    }
}