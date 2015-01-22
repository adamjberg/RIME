package views;
import haxe.ui.toolkit.containers.VBox;
import views.controls.LabelledTextInput;
import haxe.ui.toolkit.controls.selection.ListSelector;
import controllers.media.ViperMediaController;
import haxe.ui.toolkit.events.UIEvent;


class ViperMediaPopupContent extends VBox {
    
    private var xPos:LabelledTextInput;
    private var yPos:LabelledTextInput;
    private var type:LabelledTextInput;
    private var fileName:ListSelector;
    private var name:LabelledTextInput;

    private var viperMediaController:ViperMediaController;

    public function new(?viperMediaController:ViperMediaController)
    {
        this.viperMediaController = viperMediaController;
        super();

        percentWidth = 100;

        name = new LabelledTextInput("Name:");
        addChild(name);

        type = new LabelledTextInput("Type:");
        type.setText("image");
        addChild(type);

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

         fileName.addEventListener(UIEvent.CHANGE, fileNameSelected);
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

    public function getName():String
    {
        return name.getText();
    }

    public function getFileName():String
    {
        return fileName.text;
    }

    // Code for UIEVENT when fileNameList is selected goes here... working off EditmediaScreen mappingSelected code
    // which I'm assuming is what creates the isolation of the popup list
    private function fileNameSelected(e:UIEvent)
    {

        /*for(fileName in )
        {
            mapping.removeTarget(ViperMediaPopupContent);
        }

        /*var selectedMapping:Mapping = mappingController.getMappingWithName(mappingList.text);
        if(selectedMapping != null)
        {
            selectedMapping.addTarget(viperMedia.id);
        }
        else
        {
            trace("no mapping found with name: " + mappingList.text);
        }*/
    }
}