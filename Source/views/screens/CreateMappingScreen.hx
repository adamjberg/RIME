package views.screens; 

import haxe.ui.toolkit.containers.VBox;
import controllers.ScreenManager; 
import haxe.ui.toolkit.controls.selection.ListSelector;
import views.screens.Screen; 
import views.controls.LabelledTextInput;
import views.controls.FullWidthButton; 
import controllers.EffectController; 
import controllers.media.ViperMediaController; 
import controllers.EffectToMediaController; 
import haxe.ui.toolkit.events.UIEvent;
import models.EffectToMedia;  
import msignal.Signal.Signal0; 

class CreateMappingScreen extends Screen
{

	private var name:LabelledTextInput; 
	private var effectsList:ListSelector; 
	private var mediaList:ListSelector; 

	private var mediaListContent:Array<String> = new Array<String>(); 
	private var saveMappingButton:FullWidthButton;

	private var updateGUI:Signal0 = new Signal0(); 

	private var effectController:EffectController; 
	private var viperMediaController:ViperMediaController; 
	private var effectToMediaController:EffectToMediaController; 

	public function new(?effectController:EffectController, ?viperMediaController:ViperMediaController, ?effectToMediaController:EffectToMediaController)
	{
		super(); 
		percentWidth = 100; 

		updateGUI.dispatch();

		this.effectController = effectController; 
		this.effectController.loadEffectsFromDB(); 
		this.effectController.onUpdated.add(initializeEffectsListContent);

		this.viperMediaController = viperMediaController; 
		this.viperMediaController.onUpdated.add(initializeMediaListContent);
		this.effectToMediaController = effectToMediaController;

		name = new LabelledTextInput("Name: "); 
		addChild(name); 

		mediaList = new ListSelector(); 
		mediaList.percentWidth = 100; 
		mediaList.text = "Select Media"; 
		addChild(mediaList); 

		effectsList = new ListSelector(); 
		effectsList.percentWidth = 100; 
		effectsList.text = "Select Effect"; 
		addChild(effectsList); 

		saveMappingButton = new FullWidthButton("Save Mapping"); 
		saveMappingButton.onClick = saveMappingPressed;
		addChild(saveMappingButton); 

		initializeMediaListContent(); 
		initializeEffectsListContent(); 
	
	}

	private function initializeEffectsListContent()
	{
		if(effectsList.dataSource != null)
		{
			effectsList.dataSource.removeAll(); 
		}

		for(effect in effectController.effects)
		{
			effectsList.dataSource.add({
				text: effect.name
				}); 
		}
	}

	private function initializeMediaListContent() 
	{		
		if(mediaList.dataSource != null)
		{
			mediaList.dataSource.removeAll(); 
		}

		for( viperMedia in viperMediaController.mediaList)
		{
			mediaList.dataSource.add({
				text: viperMedia.name
				}); 
		}
	}

	private function saveMappingPressed(e:UIEvent)
	{
		if( name.getText() != "" ){
			if( effectsList.text != "Select Effect"){
				if(mediaList.text != "Select Media"){
					var effectToMediaObj:EffectToMedia = new EffectToMedia(name.getText(), effectController.getEffectByName(effectsList.text), viperMediaController.getViperMediaByName(mediaList.text)); 
					trace("Empty name value returns: "+name.getText()); 
					effectToMediaController.addEffectToMediaObject(effectToMediaObj); 
					ScreenManager.pop(); 
				}
			}
		}
		
	}
}