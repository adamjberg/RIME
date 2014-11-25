package views.screens;

import controllers.MappingController;
import controllers.ScreenManager;
import haxe.ui.toolkit.controls.selection.ListSelector; 
import haxe.ui.toolkit.events.UIEvent;
import models.mappings.Mapping;
import models.media.ViperMedia;
import views.controls.FullWidthButton;

class EditMediaScreen extends Screen {

    private var mappingController:MappingController;
    private var viperMedia:ViperMedia;
    private var mappingList:ListSelector;   

    private var saveButton:FullWidthButton;

    public function new(?mappingController:MappingController, ?viperMedia:ViperMedia)
    {
        super();

        mappingList = new ListSelector();
        mappingList.text = "Mapping";
        mappingList.height = 50;
        mappingList.percentWidth = 100;

        addChild(mappingList);

        this.mappingController = mappingController;
        this.viperMedia = viperMedia;

        mappingList.dataSource.add(
                {
                    text: "none"
                }
            );

        for(mapping in mappingController.mappings)
        {
            mappingList.dataSource.add(
                {
                    text: mapping.name
                }
            );
        }

        saveButton = new FullWidthButton("Save");
        saveButton.onClick = saveButtonPressed;
        addChild(saveButton);
    }

    // TODO: this is a little sloppy
    private function saveButtonPressed(e:UIEvent)
    {
        for(mapping in mappingController.mappings)
        {
            mapping.removeTarget(viperMedia.id);
        }

        var selectedMapping:Mapping = mappingController.getMappingWithName(mappingList.text);
        if(selectedMapping != null)
        {
            selectedMapping.addTarget(viperMedia.id);
        }
        else
        {
            trace("no mapping found with name: " + mappingList.text);
        }
        ScreenManager.pop();
    }
}