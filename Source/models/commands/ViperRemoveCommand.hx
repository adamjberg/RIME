package models.commands; 

import models.commands.ViperCommand;

class ViperRemoveCommand extends ViperCommand {
	
	private static var MESSAGE_TYPE:String  = "delete"; 

	public function new(id:Int)
	{
		super(id, MESSAGE_TYPE); 
	}
}