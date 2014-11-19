package views;

import haxe.ui.toolkit.containers.VBox;
import views.controls.LabelledTextInput;

class ViperMediaPopupContent extends VBox {

    private var xPos:LabelledTextInput;
    private var yPos:LabelledTextInput;
    private var type:LabelledTextInput;
    private var fileName:LabelledTextInput;

    public function new()
    {
        super();

        percentWidth = 100;

        type = new LabelledTextInput("Type:");
        type.setText("image");
        addChild(type);

        fileName = new LabelledTextInput("Filename:");
        addChild(fileName);

        xPos = new LabelledTextInput("X:");
        xPos.setText("0");

        yPos = new LabelledTextInput("Y:");
        yPos.setText("0");

        addChild(xPos);
        addChild(yPos);
    }

    public function getX():Int
    {
        return Std.parseInt(xPos.getText());
    }

    public function getY():Int
    {
        return Std.parseInt(yPos.getText());
    }

    public function getType():String
    {
        return type.getText();
    }

    public function getFileName():String
    {
        return fileName.getText();
    }
}