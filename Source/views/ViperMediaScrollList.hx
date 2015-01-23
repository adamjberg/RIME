package views;

import controllers.MappingController;
import controllers.media.ViperMediaController;
import controllers.ScreenManager;
import haxe.ui.toolkit.containers.ScrollView;
import haxe.ui.toolkit.containers.VBox;
import haxe.ui.toolkit.events.UIEvent;
import models.media.ViperMedia;
import views.screens.EditMediaScreen;
import views.ViperMediaListItem;

class ViperMediaScrollList extends ScrollView {

    private var viperMediaController:ViperMediaController;
    private var mappingController:MappingController;
    private var viperMediaList:Array<ViperMedia>;

    private var vBox:VBox;

    public function new(?viperMediaController:ViperMediaController, ?mappingController:MappingController)
    {
        super();
        this.viperMediaController = viperMediaController;
        this.mappingController = mappingController;
        this.viperMediaList = viperMediaController.mediaList;

        this._scrollSensitivity = 1;
        this.style.borderSize = 0;
        this.percentHeight = 100;
        this.percentWidth = 95;
        this.horizontalAlign = "center";

        vBox = new VBox();
        vBox.percentWidth = 100;
        addChild(vBox);

        viperMediaController.onUpdated.add(populate);

        populate();
    }

    private function populate()
    {
        vBox.removeAllChildren();

        for(media in viperMediaList)
        {
            var viperMediaListItem:ViperMediaListItem = new ViperMediaListItem(media);
            viperMediaListItem.onClick = itemClicked;
            viperMediaListItem.onDeleteButtonPressed.add(deleteViperMedia);
            vBox.addChild(viperMediaListItem);
        }
    }

    private function itemClicked(e:UIEvent)
    {
        var viperMediaListItem:ViperMediaListItem = cast(e.component, ViperMediaListItem);
        ScreenManager.push(new EditMediaScreen(viperMediaController, viperMediaListItem.media));
    }

    private function deleteViperMedia(viperMedia:ViperMedia)
    {
        viperMediaController.deleteMedia(viperMedia);
    }

}