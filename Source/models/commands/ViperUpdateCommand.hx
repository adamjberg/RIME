package models.commands;

import models.commands.ViperCommandWithId;

class ViperUpdateCommand extends ViperCommandWithId {

    private static var MESSAGE_TYPE:String = "update";

    public function new(id:Int)
    {
        super(id, MESSAGE_TYPE);
    }
}