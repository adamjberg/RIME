package views;

import haxe.ui.toolkit.containers.ScrollView;
import haxe.ui.toolkit.containers.VBox;

class SensorScrollList extends ScrollView {
    private var vBox:VBox;

    public function new()
    {
        super();

        this.percentWidth = 90;
        this.percentHeight = 100;
        this.horizontalAlign = "center";

        vBox = new VBox();
        vBox.percentWidth = 100;
        addChild(vBox);

        for(i in 0...20)
        {
            vBox.addChild(new SensorListItem());
        }
    }
}