package views;
import haxe.ui.toolkit.containers.VBox;
import views.controls.LabelledTextInput;
import haxe.ui.toolkit.controls.selection.ListSelector;
import controllers.media.ViperMediaController;
import haxe.ui.toolkit.events.UIEvent;


class ViperMediaPopupContent extends VBox {
    
    private var xPos:LabelledTextInput;
    private var yPos:LabelledTextInput;
    private var type:ListSelector;
    private var fileName:ListSelector;
    private var name:LabelledTextInput;

    private var fileTypes:Array<String> = new Array<String>(); 

    private var viperMediaController:ViperMediaController;

    public function new(?viperMediaController:ViperMediaController)
    {
        this.viperMediaController = viperMediaController;
        super();

        percentWidth = 100;

        name = new LabelledTextInput("Name:");
        addChild(name);

        type = new ListSelector(); 
        type.text = "File Type"; 
        type.percentWidth = 100; 
        addChild(type);

        initFileTypes(); 

        fileName = new ListSelector();
        fileName.text = "Files";
        fileName.percentWidth = 100;
        addChild(fileName);

        for (i in 0...viperMediaController.fileList.length)
        {
            fileName.dataSource.add(
                {
                    text: viperMediaController.fileList[i]
                });
        }

        xPos = new LabelledTextInput("X:");
        xPos.setText("0");

        yPos = new LabelledTextInput("Y:");
        yPos.setText("0");

        addChild(xPos);
        addChild(yPos);
    }

    private function initFileTypes()
    {
        fileTypes.push("image"); 
        fileTypes.push("video"); 
        fileTypes.push("gif"); 

        for(fileType in fileTypes)
        {
            type.dataSource.add({
                text: fileType
                });
            }
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
        return type.text;
    }

    public function getName():String
    {
        return name.getText();
    }

    public function getFileName():String
    {
        return fileName.text;
    }
}