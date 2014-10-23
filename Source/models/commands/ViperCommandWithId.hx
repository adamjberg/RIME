package models.commands;

import models.commands.ViperCommand;
import osc.OscMessage;

class ViperCommandWithId extends ViperCommand {

    private static var ID_STRING:String = "id";

    private var type:String;
    private var id:Int;

    public function new(id:Int, type:String)
    {
        super();
        this.type = type;
        this.id = id; 
    }

    override public function fillOscMessage(?oscMessage:OscMessage):OscMessage
    {
        oscMessage = super.fillOscMessage(oscMessage);
        oscMessage.addString(type);
        oscMessage.addString(ID_STRING);
        oscMessage.addInt(id);
        return oscMessage;
    }
}