package models.commands;

import osc.OscMessage;

class ViperCommand {

    public static var XPOS_STRING:String = "xPos";
    public static var YPOS_STRING:String = "yPos";

    private static var ADDR_PATTERN:String = "rime";
    private static var COMMAND_STRING:String = "command";

    private static var ID_STRING:String = "id";

    public var method:String;
    private var id:Int;
    private var params:Array<String> = new Array<String>();
    private var paramValues:Array<Float> = new Array<Float>();

    public function new(id:Int, ?method:String)
    {
        this.method = method;
        this.id = id; 
    }

    public function addParam(param:String, value:Float)
    {
        params.push(param);
        paramValues.push(value);
    }

    public function fillOscMessage(?oscMessage:OscMessage):OscMessage
    {
        if(oscMessage == null)
        {
            oscMessage = new OscMessage(ADDR_PATTERN);
        }
        oscMessage.addString( COMMAND_STRING );
        oscMessage.addString(method);
        oscMessage.addString(ID_STRING);
        oscMessage.addInt(id);

        for(i in 0...params.length)
        {
            oscMessage.addString(params[i]);
            oscMessage.addFloat(paramValues[i]);
        }

        return oscMessage;
    }

    
}