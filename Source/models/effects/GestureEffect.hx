package models.effects;

import gestures.models.GestureModel;

/**
 * An effect that is triggered by a gesture
 */
class GestureEffect extends Effect {

    public var gestureModel:GestureModel;
    public var desiredValues:Array<Float>;

    public function new(?name:String, method:String, mediaProperties:Array<String>, gestureModel:GestureModel, desiredValues:Array<Float>)
    {
        super(name, method, mediaProperties);
        this.gestureModel = gestureModel;
        this.desiredValues = desiredValues;
    }
}