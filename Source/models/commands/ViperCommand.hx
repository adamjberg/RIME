package models.commands;

import osc.OscMessage;

class ViperCommand {

    public static var XPOS_STRING:String = "xPos";
    public static var YPOS_STRING:String = "yPos";

    private static var ADDR_PATTERN:String = "rime";
    private static var COMMAND_STRING:String = "command";

    public function new()
    {
        
    }

    public function fillOscMessage(?oscMessage:OscMessage):OscMessage
    {
        if(oscMessage == null)
        {
            oscMessage = new OscMessage(ADDR_PATTERN);
        }
        oscMessage.addString( COMMAND_STRING );
        return oscMessage;
    }

    
}