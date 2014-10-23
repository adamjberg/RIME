package models.commands;

import models.commands.ViperCommandWithId;

class ViperCreateCommand extends ViperCommandWithId {

    private static var MESSAGE_TYPE:String = "create";

    public function new(id:Int)
    {
        super(id, MESSAGE_TYPE);
    }
}