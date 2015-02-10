package views.screens; 
import haxe.ui.toolkit.containers.VBox;
import haxe.ui.toolkit.containers.HBox; 
import haxe.ui.toolkit.controls.selection.ListSelector;
import views.controls.LabelledTextInput;
import haxe.ui.toolkit.events.UIEvent;
import controllers.ScreenManager; 
import views.controls.FullWidthButton; 
import haxe.ui.toolkit.controls.CheckBox; 
import haxe.ui.toolkit.controls.HSlider; 
import haxe.ui.toolkit.controls.Text; 
import models.sensors.data.SensorData;
import controllers.SensorDataController; 
import views.screens.ParameterLayout; 

class NewEffectPopoutScreen extends VBox { 

	//Names 
	private var name:LabelledTextInput; 

	//Effect's sensor parameters
	private var sensorList:ListSelector; 
	private var sensorXAxisCB:CheckBox; 
	private var sensorYAxisCB:CheckBox; 
	private var sensorZAxisCB:CheckBox;  
	private var checkBoxLayout:HBox; 

	private var parameterCount:Int = 0; 

	//Effect's command parameters
	private var viperCommandParameter:LabelledTextInput;
	private var viperCommandMinValue:LabelledTextInput; 
	private var viperCommandMaxValue:LabelledTextInput; 
	private var parameterLayoutArray:Array<ParameterLayout> = new Array<ParameterLayout>(); 

	//List of Sensors and ViPerCommands
	private var sensors:Array<String> = new Array<String>(); 
	private var commands:Array<String> = new Array<String>(); 

	private var newParameterButton:FullWidthButton; 
	private var parameterContainer:VBox; 

	private var sensorDataController:SensorDataController; 
	private var _sensorVectorComponents:Array<Int> = new Array<Int>();  	

	public function new(?sensorDataController:SensorDataController)
	{
		super(); 

		this.sensorDataController = sensorDataController; 

		percentWidth = 100;

		name = new LabelledTextInput("Name: "); 
		addChild(name); 

		initializeListElements(); 

		// Declare the list of sensors 
		sensorList = new ListSelector(); 
		sensorList.percentWidth = 100; 
		sensorList.text = "Select Sensor"; 
		addChild(sensorList); 

		// Add elements to the list 
		for (i in 0...sensors.length)
		{
			sensorList.dataSource.add(
			{
				text: sensors[i]
			});
		}

		checkBoxLayout = new HBox(); 
		checkBoxLayout.percentWidth = 100; 
		initalizeAxisCheckBoxes(); 
		addChild(checkBoxLayout); 

		parameterContainer = new VBox(); 
		parameterContainer.percentWidth = 100; 
		var pLayout:ParameterLayout = new ParameterLayout(); 
		parameterContainer.addChild(pLayout);
		parameterLayoutArray.push(pLayout);
		trace("Parameter array size: "+parameterLayoutArray.length);
		addChild(parameterContainer);  

		newParameterButton = new FullWidthButton("Add A Parameter"); 
		newParameterButton.onClick = newParameterButtonPressed; 
		addChild(newParameterButton); 
		
	}

	private function newParameterButtonPressed(e:UIEvent)
	{

 		for(i in parameterCount...parameterLayoutArray.length)
 		{
			if(parameterLayoutArray[parameterCount].viperCommandParameter.getText() != ""){
				if(parameterLayoutArray[parameterCount].viperCommandMinValue.getText() != ""){
					if(parameterLayoutArray[parameterCount].viperCommandMaxValue.getText() != ""){

						var pLayout:ParameterLayout = new ParameterLayout();
						parameterContainer.addChild(pLayout); 
						parameterLayoutArray.push(pLayout); 
						parameterCount++; 
						trace("Parameter Array Size: "+parameterLayoutArray.length); 
						trace("Parameter Count: "+parameterCount); 
					}
				}
			}
		}

		
	}

	private function initializeListElements(){

		for( sensorData in sensorDataController.defaultFilteredSensorDatas )
		{
			sensors.push(sensorData.getSensorName()); 
		}

	}

	private function initalizeAxisCheckBoxes(){



		sensorXAxisCB = new CheckBox(); 
		sensorXAxisCB.text = "X"; 
		sensorXAxisCB.percentWidth = 33; 
		checkBoxLayout.addChild(sensorXAxisCB); 

		sensorYAxisCB = new CheckBox(); 
		sensorYAxisCB.text = "Y"; 
		sensorYAxisCB.percentWidth = 33; 
		checkBoxLayout.addChild(sensorYAxisCB); 

		sensorZAxisCB = new CheckBox(); 
		sensorZAxisCB.text = "Z"; 
		sensorZAxisCB.percentWidth = 33; 
		checkBoxLayout.addChild(sensorZAxisCB); 

	}

	public function getName():String
	{
		if(name.getText() != "")
		{
			return name.getText(); 
		}
		return ""; 
	}

	public function getSensor():String
	{
		if(sensorList.text != "Select Sensor")
		{
			return sensorList.text; 
		} 
		return ""; 
	}

	public function getSensorVectorComponents():Array<Int>
	{

		for(i in 0..._sensorVectorComponents.length){
			_sensorVectorComponents.pop(); 	
		}

		if(sensorXAxisCB.selected){
			_sensorVectorComponents.push(0); 
		} 
		if(sensorYAxisCB.selected){
			_sensorVectorComponents.push(1); 
		}
		if(sensorZAxisCB.selected){
			_sensorVectorComponents.push(2); 
		} 

		return _sensorVectorComponents; 
	
	}

	public function getMediaProperties():Array<String>
	{	
		var mediaProperties:Array<String> = new Array<String>(); 

		for(parameterLayout in parameterLayoutArray)
		{
			if(parameterLayout.viperCommandParameter.getText() != "")
			{
				mediaProperties.push(parameterLayout.viperCommandParameter.getText()); 
			}
		}
		return mediaProperties;
	}

	public function getMinDesiredValues():Array<Float> 
	{
		var minDesiredValues:Array<Float> = new Array<Float>(); 

		for(parameterLayout in parameterLayoutArray)
		{
			if(parameterLayout.viperCommandMinValue.getText() != "")
			{
				minDesiredValues.push(Std.parseFloat(parameterLayout.viperCommandMinValue.getText()));
			}
		}
		return minDesiredValues; 
	}

	public function getMaxDesiredValues():Array<Float>
	{
		var maxDesiredValues:Array<Float> = new Array<Float>();

		for(parameterLayout in parameterLayoutArray)
		{	
			if(parameterLayout.viperCommandMaxValue.getText() != "")
			{
				maxDesiredValues.push(Std.parseFloat(parameterLayout.viperCommandMaxValue.getText())); 
			}
		}
		return maxDesiredValues; 
	}

}