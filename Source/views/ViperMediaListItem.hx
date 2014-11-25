package views;

import haxe.ui.toolkit.containers.HBox;
import haxe.ui.toolkit.controls.Button;
import haxe.ui.toolkit.controls.Text;
import models.media.ViperMedia;
import msignal.Signal.Signal1;

class ViperMediaListItem extends HBox {

    public var onDeleteButtonPressed:Signal1<ViperMedia> = new Signal1<ViperMedia>();

    public var media:ViperMedia;

    private var nameField:Text;
    private var filenameField:Text;
    private var deleteButton:Button;

    public function new(?media:ViperMedia)
    {
        super();

        this.media = media;
        percentWidth = 100;

        style.backgroundColor = 0xFFFFFF;
        style.padding = 5;

        nameField = new Text();
        addChild(nameField);
        nameField.text = media.name;

        filenameField = new Text();
        filenameField.percentWidth = 100;
        addChild(filenameField);
        filenameField.text = media.filename;

        deleteButton = new Button();
        deleteButton.text = "delete";
        deleteButton.verticalAlign = "center";
        deleteButton.onClick = function(e)
        {
            onDeleteButtonPressed.dispatch(media);
        }
        addChild(deleteButton);
    }
}