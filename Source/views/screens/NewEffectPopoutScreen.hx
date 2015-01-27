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

class NewEffectPopoutScreen extends VBox { 

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

	//Member variables to be used as api
	private var _sensor:String = "";
	private var _axisX:Bool = false; 
	private var _axisY:Bool = false; 
	private var _axisZ:Bool = false; 
	private var _command:String = "";
	private var _commandMin:Float = -1;
	private var _commandMax:Float = -1; 

	//Save Button 
	private var saveButton:FullWidthButton; 

	public function new()
	{
		super(); 

		percentWidth = 100;
		percentHeight = 100;  

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

		saveButton = new FullWidthButton("Save"); 
		saveButton.addEventListener(UIEvent.CLICK, saveEffect); 
		addChild(saveButton); 
		
	}

	private function initializeListElements(){

		sensors.push("Accelerometer"); 
		sensors.push("Linear Accel"); 
		sensors.push("Graivty"); 
		sensors.push("Magnetic Field"); 
		sensors.push("Orientation"); 
		sensors.push("Rotation"); 
		sensors.push("Microphone");

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

	private function saveEffect(e:UIEvent){
		_sensor = sensorList.text;  
		_axisX = sensorXAxisCB.selected; 
		_axisY = sensorYAxisCB.selected; 
		_axisZ = sensorZAxisCB.selected; 
		_command = viperCommandList.text;  
		_commandMin = viperCommandMinValueHS.pos; 
		_commandMax = viperCommandMaxValueHS.pos; 

		trace("Sensor : "+_sensor); 
		trace("Axis X: "+_axisX);
		trace("Axis Y: "+_axisY); 
		trace("Axis Z: "+_axisZ); 
		trace("Command: "+_command); 
		trace("Command Min: "+_commandMin); 
		trace("Command Max: "+_commandMax); 
	}

}