package views;

import gestures.models.GestureModel;
import haxe.ui.toolkit.containers.HBox;
import haxe.ui.toolkit.controls.Button;
import haxe.ui.toolkit.controls.Text;
import msignal.Signal.Signal1;

class GestureListItem extends HBox {

    public var onDeleteButtonPressed:Signal1<GestureModel> = new Signal1<GestureModel>();

    private var name:Text;
    private var deleteButton:Button;

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

        deleteButton = new Button();
        deleteButton.text = "delete";
        deleteButton.verticalAlign = "center";
        deleteButton.onClick = function(e)
        {
            onDeleteButtonPressed.dispatch(gesture);
        }
        addChild(deleteButton);

        onClick = clicked;
    }

    private function clicked(e)
    {

    }
}