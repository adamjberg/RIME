package views;

import gestures.models.GestureModel;
import haxe.ui.toolkit.containers.HBox;
import haxe.ui.toolkit.controls.Text;

class GestureListItem extends HBox {

    private var name:Text;

    private var gesture:GestureModel;

    public function new(?gesture:GestureModel)
    {
        super();

        this.gesture = gesture;

        percentWidth = 100;

        style.backgroundColor = 0xFFFFFF;
        style.padding = 20;

        name = new Text();
        name.text = gesture.name;
        name.percentWidth = 100;
        name.textAlign = "center";
        addChild(name);

        onClick = clicked;
    }

    private function clicked(e)
    {

    }
}