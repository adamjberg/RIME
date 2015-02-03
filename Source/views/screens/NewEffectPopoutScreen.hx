package views.screens; 
import haxe.ui.toolkit.containers.VBox;
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

class NewEffectPopoutScreen extends VBox { 

	//Names 
	private var name:LabelledTextInput; 

	//Effect's sensor parameters
	private var sensorList:ListSelector; 
	private var sensorXAxisCB:CheckBox; 
	private var sensorYAxisCB:CheckBox; 
	private var sensorZAxisCB:CheckBox;  

	//Effect's command parameters
	private var viperCommandList:ListSelector;
	private var viperCommandMinValueHS:HSlider; 
	private var viperCommandMaxValueHS:HSlider; 

	//List of Sensors and ViPerCommands
	private var sensors:Array<String> = new Array<String>(); 
	private var commands:Array<String> = new Array<String>(); 
	private var mediaProperties:Array<String> = new Array<String>(); 

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

		initalizeAxisCheckBoxes(); 

		viperCommandList = new ListSelector(); 
		viperCommandList.percentWidth = 100; 
		viperCommandList.text = "ViPer Parameter"; 
		addChild(viperCommandList); 

		for (i in 0...commands.length)
		{
			viperCommandList.dataSource.add(
			{
				text: commands[i]
			});
		}

		initializeMinMaxSliders(); 
		
	}

	private function initializeListElements(){

		for( sensorData in sensorDataController.defaultFilteredSensorDatas )
		{
			sensors.push(sensorData.getSensorName()); 
		}

		commands.push("Moving"); 
		commands.push("Scaling");
		commands.push("Blur"); 
		commands.push("Gray"); 

	}

	private function initalizeAxisCheckBoxes(){

		sensorXAxisCB = new CheckBox(); 
		sensorXAxisCB.text = "X"; 
		addChild(sensorXAxisCB); 

		sensorYAxisCB = new CheckBox(); 
		sensorYAxisCB.text = "Y"; 
		addChild(sensorYAxisCB); 

		sensorZAxisCB = new CheckBox(); 
		sensorZAxisCB.text = "Z"; 
		addChild(sensorZAxisCB); 

	}

	private function initializeMinMaxSliders(){

		var minText:Text = new Text(); 
		minText.text = "Min"; 
		addChild(minText); 

		viperCommandMinValueHS = new HSlider(); 
		viperCommandMinValueHS.text = "Min"; 
		viperCommandMinValueHS.width = 300; 
		viperCommandMinValueHS.pos = 0; 
		addChild(viperCommandMinValueHS); 

		var maxText:Text = new Text(); 
		maxText.text = "Max"; 
		addChild(maxText); 

		viperCommandMaxValueHS = new HSlider(); 
		viperCommandMaxValueHS.text = "Max"; 
		viperCommandMaxValueHS.width = 300; 
		viperCommandMaxValueHS.pos = 100; 
		addChild(viperCommandMaxValueHS); 

	}
	public function getName():String
	{
		return name.getText(); 
	}

	public function getSensor():String
	{
		return sensorList.text; 
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
		for(i in 0...mediaProperties.length){
			mediaProperties.pop(); 
		}
		mediaProperties.push(viperCommandList.text); 
		return mediaProperties;
	}

	public function getMinDesiredValues():Array<Float> 
	{
		var minDesiredValues:Array<Float> = new Array<Float>(); 
		minDesiredValues.push(viperCommandMinValueHS.pos); 
		return minDesiredValues; 
	}

	public function getMaxDesiredValues():Array<Float>
	{
		var maxDesiredValues:Array<Float> = new Array<Float>();
		maxDesiredValues.push(viperCommandMaxValueHS.pos); 
		return maxDesiredValues; 
	}

}