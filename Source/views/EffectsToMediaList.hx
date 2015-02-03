package views; 

import controllers.ScreenManager; 
import views.controls.ListView; 
import controllers.EffectToMediaController; 
import views.renderers.CustomComponentRenderer; 
import models.EffectToMedia; 
import views.screens.MultiSelectListView; 

class EffectsToMediaList extends MultiSelectListView{

	private var effectToMediaController:EffectToMediaController; 
	private var effectToMediaList:Array<EffectToMedia>; 

	public function new(?effectToMediaController:EffectToMediaController)
	{
		super(); 

		this.effectToMediaController = effectToMediaController; 
		this.effectToMediaList = effectToMediaController.effectToMediaList; 

		effectToMediaController.onUpdate.add(populate); 
		populate(); 
	}

	private function populate()
	{
		dataSource.removeAll(); 

		var pos:Int = 0; 
		for(effectToMedia in effectToMediaList)
		{
			dataSource.add(
			{
				text: effectToMedia.name, 
				comoonentType: "checkbox", 
				componentType: "button", 
				componentValue: "delete"
			}); 
			var item:CustomComponentRenderer = cast(getItem(pos++), CustomComponentRenderer); 
			item.component.onClick = function(e){
				deleteEffectToMedia(effectToMedia);
			};
		}
	}

	private function deleteEffectToMedia(effectToMedia:EffectToMedia)
	{
		effectToMediaController.deleteEffectToMedia(effectToMedia); 
	}
}