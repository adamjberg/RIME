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
import haxe.ui.toolkit.containers.HBox; 

class NewPerformanceScreen extends Screen
{

	private var name:LabelledTextInput; 
	private var presetList1:ListSelector; 
	private var presetList2:ListSelector;
	private var presetList3:ListSelector; 
	private var presetList4:ListSelector;
	private var presetList5:ListSelector; 
	private var presetList6:ListSelector; 

	private var presetListContent:Array<String> = new Array<String>(); 
	private var savePerformanceButton:FullWidthButton; 

	private var row1:HBox; 
	private var row2:HBox; 
	private var row3:HBox; 

	private var presetController:PresetController; 
	private var performanceController:PerformanceController; 

	public function new(?presetController:PresetController, ?performanceController:PerformanceController)
	{
		super(); 

		this.presetController = presetController; 
		this.performanceController = performanceController; 

		percentWidth = 100; 
		percentHeight = 100; 

		trace("Creating list content"); 
		initializePresetListContent(); 

		name = new LabelledTextInput("Performance Name: "); 
		addChild(name); 

		trace("initializing buttons");
		initializeButtons(); 

		savePerformanceButton = new FullWidthButton("Save Performance"); 
		savePerformanceButton.onClick = savePerformanceButtonPressed; 
		addChild(savePerformanceButton);  
	}

	private function initializeButtons()
	{
		row1 = new HBox(); 
		row1.percentWidth = 100; 
		row1.percentHeight = 30; 
		row2 = new HBox();
		row2.percentWidth = 100; 
		row2.percentHeight = 30; 
		row3 = new HBox(); 
		row3.percentWidth = 100; 
		row3.percentHeight = 30; 

		// Row 1 
		presetList1 = new ListSelector(); 
		presetList1.percentWidth = 50; 
		presetList1.percentHeight = 20; 
		presetList1.text = "Button 1 Preset"; 
		row1.addChild(presetList1); 
 
 		if(presetListContent.length == 0)
 		{
 			presetList1.dataSource.add(
 				{
 					text: "None"
 				});
 		} else {
			for(i in 0...presetListContent.length)
			{
				presetList1.dataSource.add(
				{
					text: presetListContent[i]
				});
			}
		}

		presetList2 = new ListSelector(); 
		presetList2.percentHeight = 20; 
		presetList2.percentWidth = 50; 
		presetList2.text = "Button 2 Preset"; 
		row1.addChild(presetList2); 

		if(presetListContent.length == 0)
 		{
 			presetList2.dataSource.add(
 				{
 					text: "None" 
 				});
 		} else {
			for(i in 0...presetListContent.length)
			{
				presetList2.dataSource.add(
				{
					text: presetListContent[i]
				});
			}
		}

		addChild(row1); 

		presetList3 = new ListSelector(); 
		presetList3.percentWidth = 50; 
		presetList3.percentHeight = 20; 
		presetList3.text = "Button 3 Preset"; 
		row2.addChild(presetList3); 
 
 		if(presetListContent.length == 0)
 		{
 			presetList3.dataSource.add(
 				{
 					text: "None"
 				});
 		} else {
			for(i in 0...presetListContent.length)
			{
				presetList3.dataSource.add(
				{
					text: presetListContent[i]
				});
			}
		}

		presetList4 = new ListSelector(); 
		presetList4.percentHeight = 20; 
		presetList4.percentWidth = 50; 
		presetList4.text = "Button 4 Preset"; 
		row2.addChild(presetList4); 

		if(presetListContent.length == 0)
 		{
 			presetList4.dataSource.add(
 				{
 					text: "None" 
 				});
 		} else {
			for(i in 0...presetListContent.length)
			{
				presetList4.dataSource.add(
				{
					text: presetListContent[i]
				});
			}
		}

		addChild(row2);

		presetList5 = new ListSelector(); 
		presetList5.percentWidth = 50; 
		presetList5.percentHeight = 20; 
		presetList5.text = "Button 5 Preset"; 
		row3.addChild(presetList5); 
 
 		if(presetListContent.length == 0)
 		{
 			presetList5.dataSource.add(
 				{
 					text: "None"
 				});
 		} else {
			for(i in 0...presetListContent.length)
			{
				presetList5.dataSource.add(
				{
					text: presetListContent[i]
				});
			}
		}

		presetList6 = new ListSelector(); 
		presetList6.percentHeight = 20; 
		presetList6.percentWidth = 50; 
		presetList6.text = "Button 6 Preset"; 
		row3.addChild(presetList6); 

		if(presetListContent.length == 0)
 		{
 			presetList6.dataSource.add(
 				{
 					text: "None" 
 				});
 		} else {
			for(i in 0...presetListContent.length)
			{
				presetList6.dataSource.add(
				{
					text: presetListContent[i]
				});
			}
		}

		addChild(row3);  
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
		if(checkValidity()){
			var presetArray:Array<Preset> = new Array<Preset>(); 
			presetArray.push(presetController.getPresetByName(presetList1.text)); 

			if(presetList2.text != "Button 2 Preset"){
				if(presetList2.text != "None"){
					presetArray.push(presetController.getPresetByName(presetList2.text));
				}
			}

			if(presetList3.text != "Button 3 Preset"){
				if(presetList3.text != "None"){
					presetArray.push(presetController.getPresetByName(presetList3.text));
				}
			}

			if(presetList4.text != "Button 4 Preset"){
				if(presetList4.text != "None"){
					presetArray.push(presetController.getPresetByName(presetList4.text));
				}
			}

			if(presetList5.text != "Button 5 Preset"){
				if(presetList5.text != "None"){
					presetArray.push(presetController.getPresetByName(presetList5.text));
				}
			}

			if(presetList6.text != "Button 6 Preset"){
				if(presetList6.text != "None"){
					presetArray.push(presetController.getPresetByName(presetList6.text));
				}
			}
			 
			var performance:Performance = new Performance(name.getText(), presetArray); 
			performanceController.addPerformance(performance);
			ScreenManager.pop(); 
		}
	}

	private function checkValidity():Bool 
	{
		if(name.getText() != ""){
			if(presetList1.text != "None"){
				if(presetList1.text != "Button 1 Preset"){
							
					return true; 
								
				}
			}
		} 
		return false; 
	}
}