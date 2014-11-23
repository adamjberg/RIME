package views.screens;

import controllers.MappingController;
import controllers.media.ViperMediaController;
import haxe.ui.toolkit.core.PopupManager;
import haxe.ui.toolkit.events.UIEvent;
import models.media.ViperMedia;
import views.controls.FullWidthButton;
import views.screens.Screen;
import views.ViperMediaPopupContent;
import views.ViperMediaScrollList;

class ViperMediaScreen extends Screen {

    private var viperMediaController:ViperMediaController;
    private var mappingController:MappingController;

    private var viperMediaScrollList:ViperMediaScrollList;
    private var newMediaButton:FullWidthButton;
    private var requestViperBtn:FullWidthButton;

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

        requestViperBtn = new FullWidthButton("Request Files");
        addChild(requestViperBtn);

        requestViperBtn.onClick = requestViperMedia;

    }

    private function newMediaPressed(e:UIEvent)
    {
        var viperMediaPopupContent:ViperMediaPopupContent = new ViperMediaPopupContent();
        var config:Dynamic = {};
        config.buttons = 0;
        config.buttons |= PopupButton.CONFIRM;
        config.buttons |= PopupButton.CANCEL;
        PopupManager.instance.showCustom(viperMediaPopupContent, "Create Media", config, function(button)
            {
                if(button == PopupButton.CONFIRM)
                {
                    var media:ViperMedia = viperMediaController.getMediaFromFilename(viperMediaPopupContent.getFileName());
                    media.type = viperMediaPopupContent.getType();
                    media.xPos = viperMediaPopupContent.getX();
                    media.yPos = viperMediaPopupContent.getY();
                    viperMediaController.addMedia(media);
                }
            }
        );
    }

    private function requestViperMedia(e:UIEvent)
    {
        viperMediaController.requestMedia();
        removeChild(requestViperBtn);
    }
}