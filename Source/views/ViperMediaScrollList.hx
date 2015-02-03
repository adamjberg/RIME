package views;

import controllers.media.ViperMediaController;
import models.media.ViperMedia;
import views.controls.ListView;
import views.renderers.CustomComponentRenderer;

class ViperMediaScrollList extends ListView {

    private var viperMediaController:ViperMediaController;
    private var viperMediaList:Array<ViperMedia>;

    public function new(?viperMediaController:ViperMediaController)
    {
        super();
        this.viperMediaController = viperMediaController;
        this.viperMediaList = viperMediaController.mediaList;

        viperMediaController.onUpdated.add(populate);

        populate();
    }

    private function populate()
    {
        dataSource.removeAll();

        var pos:Int = 0;
        for(media in viperMediaList)
        {
            dataSource.add(
                {
                    text: media.name,
                    subtext: media.filename,
                    componentType: "button",
                    componentValue: "delete"
                }
            );
            var item:CustomComponentRenderer = cast(getItem(pos++), CustomComponentRenderer);
            item.component.onClick = function(e) {
                deleteViperMedia(media);
            };
        }
    }

    private function deleteViperMedia(viperMedia:ViperMedia)
    {
        viperMediaController.deleteMedia(viperMedia);
    }

}