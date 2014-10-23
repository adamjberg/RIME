package models.commands;

import models.commands.ViperUpdateCommand;
import osc.OscMessage;

class ViperUpdatePositionCommand extends ViperUpdateCommand {

    private var xPos:Float;
    private var yPos:Float;

    public function new(id:Int, xPos:Float, yPos:Float)
    {
        super(id);
        
        this.xPos = xPos;
        this.yPos = yPos;
    }

    override public function fillOscMessage(?oscMessage:OscMessage):OscMessage
    {
        oscMessage = super.fillOscMessage(oscMessage);
        oscMessage.addString(ViperCommand.XPOS_STRING);
        oscMessage.addFloat(xPos);
        oscMessage.addString(ViperCommand.YPOS_STRING);
        oscMessage.addFloat(yPos);
        return oscMessage;
    }
}