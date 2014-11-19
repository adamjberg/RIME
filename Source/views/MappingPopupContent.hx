package views;

import haxe.ui.toolkit.containers.VBox;
import openfl.utils.SystemPath;
import views.controls.LabelledTextInput;

class MappingPopupContent extends VBox {

    private var fileName:LabelledTextInput;

    public function new()
    {
        super();

        percentWidth = 100;

        fileName = new LabelledTextInput("Filename:");
        fileName.setText(SystemPath.documentsDirectory); 
        addChild(fileName);
    }

    public function getFileName():String
    {
        return fileName.getText();
    }
}