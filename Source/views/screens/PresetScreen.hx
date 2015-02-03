package views.screens; 

import controllers.ScreenManager;
import views.screens.Screen; 
import views.PresetList;  
import views.controls.FullWidthButton; 
import views.screens.NewPresetScreen; 
import controllers.ScreenManager; 
import controllers.EffectController; 
import controllers.EffectToMediaController; 
import controllers.PresetController; 
import controllers.media.ViperMediaController; 
import haxe.ui.toolkit.controls.Text; 
import haxe.ui.toolkit.events.UIEvent; 
import haxe.ui.toolkit.core.PopupManager;

class PresetScreen extends Screen {

	//Controllers to pass data 
	private var effectToMediaController:EffectToMediaController; 
	private var effectController:EffectController; 
	private var viperMediaController:ViperMediaController;  
	private var presetController:PresetController; 

	private var newPresetScreen:NewPresetScreen; 

	//UI elements to fill with data 
	private var presetList:PresetList; 
	private var newPresetButton:FullWidthButton; 

	public function new(?presetController:PresetController, ?effectToMediaController:EffectToMediaController, ?effectController:EffectController, ?viperMediaController:controllers.media.ViperMediaController)
	{
		super(); 

		this.effectToMediaController = effectToMediaController; 
		this.effectController = effectController; 
		this.viperMediaController = viperMediaController;
		this.presetController = presetController;  

		presetList = new PresetList(presetController); 
		presetList.percentHeight = 100; 
		addChild(presetList); 

		newPresetButton = new FullWidthButton("New Preset"); 
		newPresetButton.onClick = newPresetButtonClicked; 
		addChild(newPresetButton); 

		newPresetScreen = new NewPresetScreen(effectToMediaController, effectController, viperMediaController); 

	}

	private function newPresetButtonClicked(e:UIEvent)
	{
		ScreenManager.push(newPresetScreen); 
	}
}