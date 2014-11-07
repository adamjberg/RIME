package models.mappings;

import models.commands.ViperCommand;
import msignal.Signal.Signal1;

class MappingData {

    public static inline var TYPE_SENSOR:String = "sensor";
    public static inline var TYPE_PIANO:String = "piano";

    public var onRequestSend:Signal1<MappingData> = new Signal1<MappingData>();

    public function new()
    {

    }

    public function fillViperCommand(command:ViperCommand)
    {

    }
}