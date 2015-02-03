package views.screens; 

import controllers.ScreenManager; 
import controllers.PerformanceController;
import controllers.PresetController; 
import haxe.ui.toolkit.controls.selection.ListSelector;
import views.screens.Screen; 
import views.controls.LabelledTextInput;
import views.controls.FullWidthButton; 
import haxe.ui.toolkit.events.UIEvent;
import models.Performance; 
import models.Preset; 

class NewPerformanceScreen extends Screen
{

	private var name:LabelledTextInput; 
	private var presetList1:ListSelector; 
	private var presetList2:ListSelector; 

	private var presetListContent:Array<String> = new Array<String>(); 
	private var savePerformanceButton:FullWidthButton; 

	private var presetController:PresetController; 
	private var performanceController:PerformanceController; 

	public function new(?presetController:PresetController, ?performanceController:PerformanceController)
	{
		super(); 

		this.presetController = presetController; 
		this.performanceController = performanceController; 

		initializePresetListContent(); 

		name = new LabelledTextInput("Performance Name: "); 
		addChild(name); 

		presetList1 = new ListSelector(); 
		presetList1.percentWidth = 50; 
		presetList1.percentHeight = 20; 
		presetList1.text = "Button 1 Preset"; 
		addChild(presetList1); 
 
		for(i in 0...presetListContent.length)
		{
			presetList1.dataSource.add(
			{
				text: presetListContent[i]
			});
		}

		presetList2 = new ListSelector(); 
		presetList2.percentHeight = 20; 
		presetList2.percentWidth = 50; 
		presetList2.text = "Button 2 Preset"; 
		addChild(presetList2); 

		for(i in 0...presetListContent.length)
		{
			presetList2.dataSource.add(
			{
				text: presetListContent[i]
			});
		}

		savePerformanceButton = new FullWidthButton("Save Performance"); 
		savePerformanceButton.onClick = savePerformanceButtonPressed; 
		addChild(savePerformanceButton);  
	}

	private function initializePresetListContent()
	{
		for(preset in presetController.presets)
		{
			presetListContent.push(preset.name); 
		}
	}

	private function savePerformanceButtonPressed(e:UIEvent)
	{
		if(name.getText() != "Performance Name: "){
			if(presetList1.text != "Button 1 Preset"){
				if(presetList2.text != "Button 2 Preset"){
					var presetArray:Array<Preset> = new Array<Preset>(); 
					presetArray.push(presetController.getPresetByName(presetList1.text)); 
					presetArray.push(presetController.getPresetByName(presetList2.text)); 
					var performance:Performance = new Performance(name.getText(), presetArray); 
					performanceController.addPerformance(performance);
					ScreenManager.pop(); 
				}
			}
		}
	}
}