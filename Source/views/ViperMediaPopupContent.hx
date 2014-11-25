package views;
import haxe.ui.toolkit.containers.VBox;
import views.controls.LabelledTextInput;
import haxe.ui.toolkit.controls.selection.ListSelector;
import controllers.media.ViperMediaController;

class ViperMediaPopupContent extends VBox {
    
    private var xPos:LabelledTextInput;
    private var yPos:LabelledTextInput;
    private var type:LabelledTextInput;
    private var fileName:ListSelector;

    public function new()
    {
        super();

        percentWidth = 100;

        type = new LabelledTextInput("Type:");
        type.setText("image");
        addChild(type);

        fileName = new ListSelector();
        fileName.text = "Files";
        fileName.percentWidth = 100;
        addChild(fileName);

        fileName.dataSource.add(
                {
                    text: "none"
                }
            );

        for (i in ViperMediaController.fileList.length)
        {
            fileName.dataSource.add(
                {
                    text: ViperMediaController.fileList[i]
                });
        }

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