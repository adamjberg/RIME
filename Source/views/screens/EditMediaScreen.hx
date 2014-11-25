package views.screens;

import controllers.MappingController;
import controllers.media.ViperMediaController;
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

    private var viperMediaController:ViperMediaController;

    private var viperCreateButton:FullWidthButton;
    private var viperDeleteButton:FullWidthButton;

    public function new(?viperMediaController:ViperMediaController, ?mappingController:MappingController, ?viperMedia:ViperMedia)
    {
        super();

        mappingList = new ListSelector();
        mappingList.text = "Mapping";
        mappingList.height = 50;
        mappingList.percentWidth = 100;

        addChild(mappingList);

        this.viperMediaController = viperMediaController;
        this.mappingController = mappingController;
        this.viperMedia = viperMedia;

        mappingList.listSize = mappingController.mappings.length + 1;

        mappingList.dataSource.add(
            {
                text: "none"
            }
        );

        for(i in 0...mappingController.mappings.length)
        {
            mappingList.dataSource.add(
                {
                    text: mappingController.mappings[i].name
                }
            );
            if(viperMedia.mapping != null)
            {
                if(mappingController.mappings[i].name == viperMedia.mapping.name)
                {
                    // Select the mapping with the same name
                    // Plus one because we added the none option
                    mappingList.selectedIndex = i + 1;
                }
            }
        }

        mappingList.addEventListener(UIEvent.CHANGE, mappingSelected);

        viperCreateButton = new FullWidthButton("Create On Viper");
        viperCreateButton.onClick = viperCreatePressed;
        addChild(viperCreateButton);

        viperDeleteButton = new FullWidthButton("Delete On Viper");
        viperDeleteButton.onClick = viperDeletePressed;
        addChild(viperDeleteButton);
    }

    // TODO: this is a little sloppy
    private function mappingSelected(e:UIEvent)
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
    }

    private function viperCreatePressed(e:UIEvent)
    {
        viperMediaController.createMediaOnViper(viperMedia);
    }

    private function viperDeletePressed(e:UIEvent)
    {
        viperMediaController.removeMediaFromViper(viperMedia);
    }
}