package widgets; 

import openfl.events.Event;
import openfl.events.MouseEvent;
import haxe.ui.toolkit.core.Component; 
import haxe.ui.toolkit.core.interfaces.IDraggable;
import widgets.Platform;

class Circle extends Component implements IDraggable
{
	var platform:Platform; 

	public function new()
	{
		super(); 
		percentWidth = 100; 
		percentHeight = 100; 

	}

	override public function paint()
	{
		this.graphics.clear(); 
		this.graphics.beginFill(0x000000);
		this.graphics.drawCircle(10,10,100);
		this.graphics.endFill();
	}

	public function allowDrag(event:MouseEvent):Bool
	{
		trace("Allow Drag Function");
		if(this.hitTest(event.stageX, event.stageY)){
			trace("Within Object Boundaries"); 
			return true; 
		} else {
			trace("Outside of Obeject Boundaries"); 
			return false; 
		}
		 
	}

	override private function _onComponentMouseMove(event:MouseEvent):Void
	{
		this.x = event.stageX - mouseDownPos.x; 
		this.y = event.stageY - mouseDownPos.y - 60; // to accomodate for title bar.
	}
}