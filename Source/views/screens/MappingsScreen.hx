package views.screens;

import controllers.MappingController;
import controllers.ScreenManager;
import haxe.ui.toolkit.containers.VBox;
import haxe.ui.toolkit.controls.Button;
import haxe.ui.toolkit.core.PopupManager;
import haxe.ui.toolkit.events.UIEvent;
import models.mappings.Mapping;
import models.ServerInfo;
import controllers.Client;
import views.controls.FullWidthButton;
import views.MappingPopupContent;
import views.screens.Screen;

class MappingsScreen extends Screen {

    private var mappingController:MappingController;
    private var addMappingButton:FullWidthButton;

    public function new(?mappingController:MappingController) {
        super();

        this.mappingController = mappingController;

        var mappingScrollList:MappingScrollList = new MappingScrollList(mappingController);
        addChild(mappingScrollList);

        addMappingButton = new FullWidthButton("Add");
        addMappingButton.onClick = mappingButtonPressed;
        addChild(addMappingButton);
    }

    private function mappingButtonPressed(e:UIEvent)
    {
        var mappingPopupContent:MappingPopupContent = new MappingPopupContent();
        var buttons:Int = 0;
        buttons |= PopupButton.CONFIRM;
        buttons |= PopupButton.CANCEL;
        PopupManager.instance.showCustom(mappingPopupContent, "Load Mapping", buttons, function(button)
            {
                if(button == PopupButton.CONFIRM)
                {
                    mappingController.addMappingFromFile(mappingPopupContent.getFileName());
                }
            }
        );
    }
}