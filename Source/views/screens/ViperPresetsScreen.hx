package views.screens;

import views.screens.ViperMediaScreen;
import views.controls.FullWidthButton;
import controllers.media.ViperMediaController;
import controllers.MappingController;
import openfl.events.MouseEvent; 
import controllers.ScreenManager;


class ViperPresetsScreen extends Screen {

	private var viperMediaScreen:ViperMediaScreen; 
	private var newPresetButton:FullWidthButton; 
	private var viperMediaController:ViperMediaController; 
	private var mappingController:MappingController;


	public function new( ?viperMediaControllerX:ViperMediaController, ?mappingControllerX:MappingController){
		super(); 
		percentHeight = 100; 
		percentWidth = 100; 

		this.viperMediaController = viperMediaControllerX; 
		this.mappingController = mappingControllerX; 

		init(); 

	}

	private function init(){

		newPresetButton = new FullWidthButton("Create New Preset"); 
		newPresetButton.addEventListener(MouseEvent.CLICK, newPreset); 
		addChild(newPresetButton); 

	}

	private function newPreset(e:MouseEvent){

        ScreenManager.push(new ViperMediaScreen(viperMediaController, mappingController)); //pass these in from the constructor 
        trace("Adding new Media Screen"); 

	}

}
