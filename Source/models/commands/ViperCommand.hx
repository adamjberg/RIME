package models.commands;

import osc.OscMessage;

class ViperCommand {

    public static var XPOS_STRING:String = "xPos";
    public static var YPOS_STRING:String = "yPos";

    private static var ADDR_PATTERN:String = "rime";
    private static var METHOD_STRING:String = "method";

    private static var ID_STRING:String = "id";

    public var method:String;
    public var id:Int;
    private var params:Array<String> = new Array<String>();
    private var paramValues:Array<Dynamic> = new Array<Dynamic>();

    public function new(?id:Int, ?method:String)
    {
        this.method = method;
        this.id = id; 
    }

    public function addParam(param:String, value:Dynamic)
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
        oscMessage.addString( METHOD_STRING );
        oscMessage.addString(method);
        oscMessage.addString(ID_STRING);
        oscMessage.addInt(id);

        for(i in 0...params.length)
        {
            oscMessage.addString(params[i]);
            if(Std.is(paramValues[i], Float))
            {
                oscMessage.addFloat(paramValues[i]);
            }
            else if(Std.is(paramValues[i], String))
            {
                oscMessage.addString(paramValues[i]);
            }
        }

        return oscMessage;
    }

    
}