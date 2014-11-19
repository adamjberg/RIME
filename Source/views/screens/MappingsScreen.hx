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
import openfl.utils.SystemPath;


class MappingsScreen extends Screen {
    //private static var DIRECTORY:String = SystemPath.applicationStorageDirectory + "/jsonfile";
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
                    #if (ios && openfl)
                    mappingController.addMappingFromFile(SystemPath.applicationStorageDirectory +"/"+ mappingPopupContent.getFileName());
                    #elseif (android && openfl)
                    mappingController.addMappingFromFile(SystemPath.documentsDirectory +"/Download/" + mappingPopupContent.getFileName());
                    #else
                    mappingController.addMappingFromFile(SystemPath.userDirectory + "/" + mappingPopupContent.getFileName());
                    #end
                }
            }
        );
    }
}