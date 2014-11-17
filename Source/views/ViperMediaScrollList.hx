package views;

import controllers.media.ViperMediaController;
import haxe.ui.toolkit.containers.ScrollView;
import haxe.ui.toolkit.containers.VBox;
import models.media.ViperMedia;
import views.ViperMediaListItem;

class ViperMediaScrollList extends ScrollView {

    private var viperMediaController:ViperMediaController;
    private var viperMediaList:Array<ViperMedia>;

    private var vBox:VBox;

    public function new(?viperMediaController:ViperMediaController)
    {
        super();
        this.viperMediaController = viperMediaController;
        this.viperMediaList = viperMediaController.activeMediaList;

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
            viperMediaListItem.onDeleteButtonPressed.add(deleteViperMedia);
            vBox.addChild(viperMediaListItem);
        }
    }

    private function deleteViperMedia(viperMedia:ViperMedia)
    {
        viperMediaController.deleteMedia(viperMedia);
    }

}