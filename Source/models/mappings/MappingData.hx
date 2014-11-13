package models.mappings;

import models.commands.ViperCommand;
import msignal.Signal.Signal1;

class MappingData {

    public static inline var TYPE_SENSOR:String = "sensor";
    public static inline var TYPE_PIANO:String = "piano";
    public static inline var TYPE_GESTURE:String = "gesture";

    public var onRequestSend:Signal1<MappingData> = new Signal1<MappingData>();
    public var viperCommands:Array<ViperCommand> = new Array<ViperCommand>();

    public function new()
    {

    }

    public function isValid():Bool
    {
        return true;
    }

    public function clearViperCommands()
    {
        viperCommands = new Array<ViperCommand>();
    }

    public function addViperCommand(command:ViperCommand)
    {
        viperCommands.push(command);
    }

    public function getViperCommands():Array<ViperCommand>
    {
        return viperCommands;
    }
}