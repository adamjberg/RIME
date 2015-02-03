package widgets; 

import haxe.ui.toolkit.core.Component; 

class Platform extends Component 
{
	private function new()
	{
		super(); 
	}

	override public function paint()
	{
		this.graphics.clear();
		this.graphics.beginFill(0xFF0000); 
		this.graphics.drawRect(0,0,100, 100); 
		this.graphics.endFill(); 
	}

}