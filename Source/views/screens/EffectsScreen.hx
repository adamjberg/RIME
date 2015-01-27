package views.screens; 

import controllers.ScreenManager;
import views.screens.Screen; 
import views.controls.FullWidthButton; 
import haxe.ui.toolkit.controls.Text; 
import views.screens.NewEffectPopoutScreen; 
import views.EffectsList; 

class EffectsScreen extends Screen { 

	public var newEffectButton:FullWidthButton;
	public var effectsList:EffectsList; 

	public function new(){
		super(); 

		effectsList = new EffectsList(); 
		effectsList.percentHeight = 100; 
		addChild(effectsList); 	
 
		newEffectButton = new FullWidthButton("New Effect");
		newEffectButton.onClick = newEffectButtonClicked; 
		addChild(newEffectButton); 
	}

	private function newEffectButtonClicked(e)
	{
		ScreenManager.push(new NewEffectPopoutScreen()); 
	}

}