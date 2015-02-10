package views; 

import views.controls.ListView; 
import models.Preset; 
import controllers.ScreenManager; 
import controllers.PresetController; 
import views.renderers.CustomComponentRenderer; 

class PresetList extends ListView{

	private var presetController:PresetController; 
	private var presetList:Array<Preset>; 

	public function new(?presetController:PresetController)
	{
		super(); 

		this.presetController = presetController; 
		this.presetList = presetController.presets; 

		presetController.onUpdated.add(populate); 
		populate();
	}

	private function populate()
	{
		dataSource.removeAll(); 

		var pos:Int = 0; 
		for(preset in presetList)
		{
			trace(preset.name);
			dataSource.add(
			{
				text: preset.name,
				componentType: "button", 
				componentValue: "delete"
			}); 
			var item:CustomComponentRenderer = cast(getItem(pos++), CustomComponentRenderer); 
			if(item.component != null)
			{
			item.component.onClick = function(e){
				deletePreset(preset); 
			};
			}
			else{
				trace("NULL");
			} 
		}
	}

	private function deletePreset(preset:Preset)
	{
		presetController.deletePreset(preset); 
	}
}