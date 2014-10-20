package views;

import haxe.ui.toolkit.containers.MenuBar;
import haxe.ui.toolkit.controls.Text;

class HeaderBar extends MenuBar {
    private var title:Text;

    public function new() {
        super();

        this.percentWidth = 100;

        title = new Text();
        title.style.fontSize = 40;
        title.text = "RIME";
        title.autoSize = false;
        title.percentWidth = 100;
        title.percentHeight = 100;
        title.horizontalAlign = "center";
        title.textAlign = "center";
        addChild(title);
    }
}