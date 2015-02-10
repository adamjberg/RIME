package views.screens; 

import controllers.ScreenManager; 
import views.screens.Screen; 
import views.EffectsList; 
import views.controls.LabelledTextInput;
import haxe.ui.toolkit.core.PopupManager; 
import haxe.ui.toolkit.events.UIEvent; 
import haxe.ui.toolkit.core.interfaces.IItemRenderer;
import controllers.EffectController; 
import controllers.PresetController; 
import controllers.EffectToMediaController; 
import controllers.media.ViperMediaController; 	
import views.controls.FullWidthButton; 
import views.screens.CreateMappingScreen; 
import views.EffectsToMediaList; 
import models.Preset; 
import models.EffectToMedia; 
import msignal.Signal.Signal0; 


class NewPresetScreen extends Screen 
{

	private var effectToMediaController:EffectToMediaController; 
	private var effectController:EffectController; 
	private var viperMediaController:ViperMediaController;
	private var presetController:PresetController; 

	private var name:LabelledTextInput; 
	private var effectToMediaList:EffectsToMediaList; 
	private var addMappingButton:FullWidthButton; 
	private var savePresetButton:FullWidthButton;

	private var updateGUI:Signal0 = new Signal0(); 

	private var createMappingScreen:CreateMappingScreen; 

	public function new(?presetController:PresetController, ?effectToMediaController:EffectToMediaController, ?effectController:EffectController, ?viperMediaController:ViperMediaController)
	{
		super(); 

		this.effectToMediaController = effectToMediaController; 
		this.effectController = effectController; 
		this.viperMediaController = viperMediaController; 
		this.presetController = presetController; 

		name = new LabelledTextInput("Preset Name: "); 
		addChild(name); 

		effectToMediaList = new EffectsToMediaList(effectToMediaController); 
		effectToMediaList.percentHeight = 100; 
		addChild(effectToMediaList); 

		createMappingScreen = new CreateMappingScreen(effectController, viperMediaController, effectToMediaController); 

		addMappingButton = new FullWidthButton("Add Mapping"); 
		addMappingButton.percentWidth = 100; 
		addMappingButton.onClick = openMappingPopout; 
		addChild(addMappingButton); 

		savePresetButton = new FullWidthButton("Save Preset"); 
		savePresetButton.percentWidth = 100; 
		savePresetButton.onClick = savePresetPressed; 
		addChild(savePresetButton); 

	}

	private function openMappingPopout(e:UIEvent)
	{
		ScreenManager.push(createMappingScreen); 	
	}

	private function savePresetPressed(e:UIEvent)
	{
		var selectedEffectToMedia:Array<EffectToMedia> = new Array<EffectToMedia>(); 
		var selectedItems:Array<IItemRenderer> = new Array<IItemRenderer>(); 

		selectedItems = effectToMediaList.get_selectedItems2(); 

		for(selectedItem in selectedItems)
		{
			selectedEffectToMedia.push(effectToMediaController.getEffectToMediaByName(selectedItem.data.text)); 
		}

		if(selectedItems.length != 0){
			if(name.getText() != ""){
				var preset:Preset = new Preset(name.getText(), selectedEffectToMedia); 
				if(presetController != null){
					presetController.addPreset(preset); 
					ScreenManager.pop(); 

				}
			}
		}
	}
}