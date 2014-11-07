package models.commands;

import models.commands.ViperCommand;

class ViperUpdateCommand extends ViperCommand {

    private static var MESSAGE_TYPE:String = "update";

    public function new(id:Int)
    {
        super(id, MESSAGE_TYPE);
    }
}