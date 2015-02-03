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

class CreateMappingScreen extends Screen
{

	private var name:LabelledTextInput; 
	private var effectsList:ListSelector; 
	private var mediaList:ListSelector; 

	private var mediaListContent:Array<String> = new Array<String>(); 
	private var effectsListContent:Array<String> = new Array<String>(); 
	private var saveMappingButton:FullWidthButton;

	private var effectController:EffectController; 
	private var viperMediaController:ViperMediaController; 
	private var effectToMediaController:EffectToMediaController; 

	public function new(?effectController:EffectController, ?viperMediaController:ViperMediaController, ?effectToMediaController:EffectToMediaController)
	{
		super(); 
		percentWidth = 100; 

		this.effectController = effectController; 
		this.effectController.loadEffectsFromDB(); 
		this.viperMediaController = viperMediaController; 
		this.effectToMediaController = effectToMediaController; 

		initializeMediaListContent(); 
		initializeEffectsListContent(); 

		name = new LabelledTextInput("Name: "); 
		addChild(name); 

		mediaList = new ListSelector(); 
		mediaList.percentWidth = 100; 
		mediaList.text = "Select Media"; 
		addChild(mediaList); 

		for(i in 0...mediaListContent.length)
		{
			mediaList.dataSource.add(
			{
				text: mediaListContent[i]
			});
		}

		effectsList = new ListSelector(); 
		effectsList.percentWidth = 100; 
		effectsList.text = "Select Effect"; 
		addChild(effectsList); 

		for(i in 0...effectsListContent.length)
		{
			effectsList.dataSource.add(
			{
				text: effectsListContent[i]
			}); 
		}

		saveMappingButton = new FullWidthButton("Save Mapping"); 
		saveMappingButton.onClick = saveMappingPressed;
		addChild(saveMappingButton); 
	
	}

	private function initializeMediaListContent()
	{
		for(effect in effectController.effects)
		{
			effectsListContent.push(effect.name); 
		}
		trace("Length of effectListContent: "+effectsListContent.length); 

		
	}

	private function initializeEffectsListContent()
	{
		for( viperMedia in viperMediaController.mediaList)
		{
			mediaListContent.push(viperMedia.name); 
		}
		trace("Length of mediaListcontent: "+mediaListContent.length); 
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