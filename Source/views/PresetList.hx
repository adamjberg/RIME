package views; 

import views.controls.ListView; 
import models.Preset; 
import controllers.ScreenManager; 
import controllers.PresetController; 
import views.renderers.CustomComponentRenderer; 

class PresetList extends ListView{

	private var presetController:PresetController; 
	private var presetList:Array<Preset> = new Array<Preset>(); 

	public function new(?presetController:PresetController)
	{
		super(); 

		this.presetController = presetController; 
		presetController.loadPresetsFromDB(); 
		this.presetList = presetController.presets; 

		if(presetList.length == 0 ){
			trace("Preset controller is empty or fucked up"); 
		}
	}

	private function populate()
	{
		dataSource.removeAll(); 

		var pos:Int = 0; 
		for(preset in presetList)
		{
			dataSource.add(
			{
				text: preset.name, 
				componentTye: "button", 
				componentValue: "delete"
			}); 
			var item:CustomComponentRenderer = cast(getItem(pos++), CustomComponentRenderer); 
			item.component.onClick = function(e){
				deletePreset(preset); 
			}; 
		}
	}

	private function deletePreset(preset:Preset)
	{
		presetController.deletePreset(preset); 
	}
}