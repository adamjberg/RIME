package models.mappings;

import gestures.controllers.GestureController;
import gestures.models.GestureModel;
import models.commands.ViperCommand;
import models.mappings.MappingData;

class GestureMappingData extends MappingData {

    public var gestureId:Int;
    public var method:String;
    public var targetField:String;
    public var targetOutput:Float;

    public function new(gestureController:GestureController, gestureId:Int, method:String, targetField:String, targetOutput:Float)
    {
        super();

        this.gestureId = gestureId;
        this.method = method;
        this.targetField = targetField;
        this.targetOutput = targetOutput;

        gestureController.onGestureDetected.add(requestSend);
    }

    override public function fillViperCommand(viperCommand:ViperCommand)
    {
        viperCommand.method = method;
        viperCommand.addParam(targetField, targetOutput);
    }

    private function requestSend(gestureDetected:Int, prob:Float)
    {
        if(gestureDetected == gestureId)
        {
            onRequestSend.dispatch(this);
        }
    }
}