package models.mappings;

import gestures.controllers.GestureController;
import gestures.models.GestureModel;
import models.commands.ViperCommand;
import models.mappings.MappingData;

class GestureMappingData extends MappingData {

    public var gestureId:Int;

    public function new(gestureController:GestureController, gestureId:Int)
    {
        super();

        this.gestureId = gestureId;

        gestureController.onGestureDetected.add(requestSend);
    }

    private function requestSend(gestureDetected:Int, prob:Float)
    {
        if(gestureDetected == gestureId)
        {
            onRequestSend.dispatch(this);
        }
    }
}