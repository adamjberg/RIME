package views.screens;

import controllers.MappingController;
import controllers.ScreenManager;
import haxe.ui.toolkit.controls.Button;
import models.mappings.Mapping;
import models.ServerInfo;
import controllers.Client;
import views.screens.Screen;

class MappingsScreen extends Screen {

    private var mappingController:MappingController;

    public function new(?mappingController:MappingController) {
        super();

        this.mappingController = mappingController;

        var mappingScrollList:MappingScrollList = new MappingScrollList(mappingController);
        addChild(mappingScrollList);
    }
}