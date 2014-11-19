package views.screens;

import controllers.MappingController;
import controllers.media.ViperMediaController;
import haxe.ui.toolkit.core.PopupManager;
import haxe.ui.toolkit.events.UIEvent;
import views.controls.FullWidthButton;
import views.screens.Screen;
import views.ViperMediaPopupContent;
import views.ViperMediaScrollList;

class ViperMediaScreen extends Screen {

    private var viperMediaController:ViperMediaController;
    private var mappingController:MappingController;

    private var viperMediaScrollList:ViperMediaScrollList;
    private var newMediaButton:FullWidthButton;

    public function new(?viperMediaController:ViperMediaController, ?mappingController:MappingController)
    {
        super();

        this.viperMediaController = viperMediaController;
        this.mappingController = mappingController;

        viperMediaScrollList = new ViperMediaScrollList(viperMediaController, mappingController);
        addChild(viperMediaScrollList);

        newMediaButton = new FullWidthButton("NEW");
        addChild(newMediaButton);

        newMediaButton.onClick = newMediaPressed;
    }

    private function newMediaPressed(e:UIEvent)
    {
        var viperMediaPopupContent:ViperMediaPopupContent = new ViperMediaPopupContent();
        var buttons:Int = 0;
        buttons |= PopupButton.CONFIRM;
        buttons |= PopupButton.CANCEL;
        PopupManager.instance.showCustom(viperMediaPopupContent, "Create Media", buttons, function(button)
            {
                if(button == PopupButton.CONFIRM)
                {
                    viperMediaController.addMediaFromFilename(viperMediaPopupContent.getFileName());
                }
            }
        );
    }
}