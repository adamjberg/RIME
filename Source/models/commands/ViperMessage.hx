package models.commands;

import osc.OscMessage;

class ViperMessage
{
	private static var ADDR_PATTERN:String = "viper";
	public var method:String;
    public var id:Int;

    public function new(?id:Int, ?method:String)
    {
        this.method = method;
        this.id = id; 
    }

    public function fillOscMessage(?oscMessage:OscMessage):OscMessage
    {
        if(oscMessage == null)
        {
            oscMessage = new OscMessage(ADDR_PATTERN);
        }

        return oscMessage;
    }
}