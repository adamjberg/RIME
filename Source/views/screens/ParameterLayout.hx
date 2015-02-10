package views.screens; 

import haxe.ui.toolkit.containers.VBox;
import haxe.ui.toolkit.containers.HBox; 
import haxe.ui.toolkit.controls.Button; 
import views.controls.LabelledTextInput;

class ParameterLayout extends VBox {

	public var viperCommandParameter:LabelledTextInput; 
	public var viperCommandMinValue:LabelledTextInput;  
	public var viperCommandMaxValue:LabelledTextInput; 

	private var minMaxLayout:HBox; 

	public function new()
	{
		super(); 

		percentWidth = 100; 

		viperCommandParameter = new LabelledTextInput("Parameter: "); 
		viperCommandParameter.percentWidth = 100; 
		addChild(viperCommandParameter); 

		minMaxLayout = new HBox(); 
		minMaxLayout.percentWidth = 100; 

		viperCommandMinValue = new LabelledTextInput("Min: "); 
		viperCommandMinValue.percentWidth = 50; 
		minMaxLayout.addChild(viperCommandMinValue);

		viperCommandMaxValue = new LabelledTextInput("Max: "); 
		viperCommandMaxValue.percentWidth = 50; 
		minMaxLayout.addChild(viperCommandMaxValue);

		addChild(minMaxLayout); 

	}

}