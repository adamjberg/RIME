package views.screens;

import controllers.media.ViperMediaController;
import controllers.ScreenManager;
import haxe.ui.toolkit.controls.selection.ListSelector; 
import haxe.ui.toolkit.events.UIEvent;
import models.media.ViperMedia;
import views.controls.FullWidthButton;

class EditMediaScreen extends Screen {
    private var viperMedia:ViperMedia;

    private var viperMediaController:ViperMediaController;

    private var viperCreateButton:FullWidthButton;
    private var viperDeleteButton:FullWidthButton;

    public function new(?viperMediaController:ViperMediaController, ?viperMedia:ViperMedia)
    {
        super();

        this.viperMediaController = viperMediaController;
        this.viperMedia = viperMedia;
        
        viperCreateButton = new FullWidthButton("Create On Viper");
        viperCreateButton.onClick = viperCreatePressed;
        addChild(viperCreateButton);

        viperDeleteButton = new FullWidthButton("Delete On Viper");
        viperDeleteButton.onClick = viperDeletePressed;
        addChild(viperDeleteButton);
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