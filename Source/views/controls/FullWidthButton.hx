package views.controls;

import haxe.ui.toolkit.controls.Button;

class FullWidthButton extends Button {

    public function new(?text:String)
    {
        super();
        autoSize = false;
        percentWidth = 100;
        this.text = text;
    }
}