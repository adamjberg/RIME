package views;

import haxe.ui.toolkit.containers.VBox;
import views.controls.LabelledTextInput;

class ViperMediaPopupContent extends VBox {

    private var fileName:LabelledTextInput;

    public function new()
    {
        super();

        percentWidth = 100;

        fileName = new LabelledTextInput("Filename:");
        addChild(fileName);
    }

    public function getFileName():String
    {
        return fileName.getText();
    }
}