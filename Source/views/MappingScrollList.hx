package views;

import controllers.MappingController;
import haxe.ui.toolkit.containers.VBox;
import haxe.ui.toolkit.containers.ScrollView;
import models.mappings.Mapping;
import openfl.events.TimerEvent;
import openfl.utils.Timer;
import views.MappingListItem;

class MappingScrollList extends ScrollView {

    private var mappingController:MappingController;
    private var mappings:Array<Mapping>;
    private var mappingListItems:Array<MappingListItem> = new Array<MappingListItem>();
    private var vBox:VBox;

    public function new(?mappingController:MappingController)
    {
        super();

        this.mappingController = mappingController;

        this._scrollSensitivity = 1;

        this.mappings = mappingController.mappings;

        this.style.borderSize = 0;

        this.percentHeight = 100;
        this.percentWidth = 95;
        this.horizontalAlign = "center";

        vBox = new VBox();
        vBox.percentWidth = 100;
        addChild(vBox);

        this.mappingController.onUpdated.add(populate);
        populate();
    }

    private function populate()
    {
        vBox.removeAllChildren();

        for(mapping in mappings)
        {
            var mappingListItem:MappingListItem = new MappingListItem(mapping);
            mappingListItems.push(mappingListItem);
            vBox.addChild(mappingListItem);
        }
    }

    private function deleteMapping(mapping:Mapping)
    {
        mappingController.deleteMapping(mapping);
    }
}