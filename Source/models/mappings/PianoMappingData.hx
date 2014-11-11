package models.mappings;

import haxe.ui.toolkit.controls.Button;
import models.commands.ViperCommand;
import models.mappings.MappingData;
import openfl.events.MouseEvent;

class PianoMappingData extends MappingData {

    public static inline var PRESS_TYPE_DOWN:String = "down";
    public static inline var PRESS_TYPE_UP:String = "up";
    public static inline var PRESS_TYPE_DOUBLE_TAP:String = "double tap";

    public var button:Button;

    public function new(button:Button, pressType:String)
    {
        super();
        this.button = button;

        var eventType:String = "";
        switch(pressType)
        {
            case(PRESS_TYPE_DOWN):
                eventType = MouseEvent.MOUSE_DOWN;
            case(PRESS_TYPE_UP):
                eventType = MouseEvent.MOUSE_UP;
            case(PRESS_TYPE_DOUBLE_TAP):
                eventType = MouseEvent.DOUBLE_CLICK;
        }
        button.addEventListener(eventType, requestSend);
    }

    private function requestSend(e:MouseEvent)
    {
        onRequestSend.dispatch(this);
    }
}