package views.controls;

import haxe.ui.toolkit.controls.Button;

class FullWidthButton extends Button {

    public function new(?text:String)
    {
        super();
        percentWidth = 100;
        this.text = text;
        this.style.textAlign = "center";
    }
}