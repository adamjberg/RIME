package models.effects;

/**
 * An effect that is triggered by a gesture
 */
class GestureEffect extends Effect {

    public var gestureName:String;
    public var desiredValues:Array<Float>;

    public function new(?name:String, method:String, mediaProperties:Array<String>, gestureName:String, desiredValues:Array<Float>)
    {
        super(name, method, mediaProperties);
        this.gestureName = gestureName;
        this.desiredValues = desiredValues;
    }
}