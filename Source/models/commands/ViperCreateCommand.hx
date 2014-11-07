package models.commands;

import models.commands.ViperCommand;

class ViperCreateCommand extends ViperCommand {

    private static var MESSAGE_TYPE:String = "create";

    public function new(id:Int)
    {
        super(id, MESSAGE_TYPE);
    }
}