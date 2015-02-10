package views.screens; 

import controllers.ScreenManager;
import views.screens.Screen; 
import views.controls.FullWidthButton; 
import haxe.ui.toolkit.controls.Text; 
import views.screens.NewEffectPopoutScreen; 
import views.EffectsList; 
import controllers.EffectController; 
import models.effects.SensorVariableEffect; 
import models.sensors.data.SensorData; 
import controllers.SensorDataController; 
import haxe.ui.toolkit.events.UIEvent;
import models.effects.SensorVariableEffect; 
import haxe.ui.toolkit.core.PopupManager;
import msignal.Signal.Signal0; 


class EffectsScreen extends Screen { 

	public var newEffectButton:FullWidthButton;
	public var effectsList:EffectsList; 

	private var effectController:EffectController; 
	private var sensorDataController:SensorDataController; 

	private var updateGUI:Signal0 = new Signal0();

	private var effectName:String = ""; 
	private var effectMethod:String = "update"; 
	private var effectMediaProperties:Array<String>; 
	private var effectMinValues:Array<Float>; 
	private var effectMaxValues:Array<Float>; 
	private var effectVectorComponenets:Array<Int>; 

	public function new(?effectController:EffectController, ?sensorDataController:SensorDataController){
		super(); 

		this.sensorDataController = sensorDataController;
		this.effectController = effectController; 

		effectsList = new EffectsList(effectController); 
		effectsList.percentHeight = 100; 
		addChild(effectsList); 	
 
		newEffectButton = new FullWidthButton("New Effect");
		newEffectButton.onClick = newEffectButtonClicked; 
		addChild(newEffectButton); 

	}

	private function newEffectButtonClicked(e:UIEvent)
	{
		var newEffectPopoutScreen:NewEffectPopoutScreen = new NewEffectPopoutScreen(sensorDataController); 
		var config:Dynamic = {};
		config.buttons = 0; 
		config.buttons |= PopupButton.CONFIRM; 
		config.buttons |= PopupButton.CANCEL; 
		PopupManager.instance.showCustom(newEffectPopoutScreen, "New Effect", config, function(button)
			{
				if(button == PopupButton.CONFIRM)
				{
						//Take the values from the GUI and save them 
						effectName = newEffectPopoutScreen.getName(); 
						effectMethod = "update";  
						effectMediaProperties = newEffectPopoutScreen.getMediaProperties();
						effectMinValues = newEffectPopoutScreen.getMinDesiredValues(); 
						effectMaxValues = newEffectPopoutScreen.getMaxDesiredValues(); 
						effectVectorComponenets = newEffectPopoutScreen.getSensorVectorComponents(); 

						var sensorName:String = newEffectPopoutScreen.getSensor(); 
						var sensorData:SensorData = sensorDataController.getRawWithName(sensorName); 
						var updateInterval:Int = 100; 
						var absoluteValue:Bool = false; 

						//Then create a new effect with them 
						var sensorVariableEffect:SensorVariableEffect = new SensorVariableEffect(
							effectName, 
							effectMethod,
							effectMediaProperties,
							sensorData,
							effectMinValues,
							effectMaxValues,
							updateInterval,
							effectVectorComponenets,
							absoluteValue); 

						if(sensorName != "")
						{
							effectController.addEffect(sensorVariableEffect); 
						}
				}

			} 
		);
	}

}