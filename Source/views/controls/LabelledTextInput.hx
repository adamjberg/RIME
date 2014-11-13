package views.controls;

import haxe.ui.toolkit.containers.HBox;
import haxe.ui.toolkit.controls.Text;
import haxe.ui.toolkit.controls.TextInput;

class LabelledTextInput extends HBox {

    private var label:Text;
    private var input:TextInput;

    public function new(?labelString:String)
    {
        super();

        label = new Text();
        label.text = labelString;

        input = new TextInput();

        addChild(label);
        addChild(input);
    }

    public function getText():String
    {
        return input.text;
    }
}