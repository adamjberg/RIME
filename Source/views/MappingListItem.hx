package views;

import haxe.ui.toolkit.containers.HBox;
import haxe.ui.toolkit.controls.Button;
import haxe.ui.toolkit.controls.Text;
import models.mappings.Mapping;
import msignal.Signal.Signal1;

class MappingListItem extends HBox {

    public var onDeleteButtonPressed:Signal1<Mapping> = new Signal1<Mapping>();

    private var name:Text;
    private var deleteButton:Button;

    private var mapping:Mapping;

    public function new(?mapping:Mapping)
    {
        super();

        this.mapping = mapping;

        percentWidth = 100;

        style.backgroundColor = 0xFFFFFF;
        style.padding = 20;

        name = new Text();
        name.text = mapping.name;
        name.percentWidth = 100;
        name.textAlign = "center";
        addChild(name);

        deleteButton = new Button();
        deleteButton.text = "delete";
        deleteButton.verticalAlign = "center";
        deleteButton.onClick = function(e)
        {
            onDeleteButtonPressed.dispatch(mapping);
        }
        addChild(deleteButton);
    }
}