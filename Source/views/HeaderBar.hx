package views;

import haxe.ui.toolkit.containers.MenuBar;
import haxe.ui.toolkit.controls.MenuButton;
import haxe.ui.toolkit.controls.Text;

class HeaderBar extends MenuBar {
    private var leftButton:MenuButton;
    private var rightButton:MenuButton;
    private var title:Text;

    public function new() {
        super();

        this.percentWidth = 100;
        this.percentHeight = 10;

        leftButton = new MenuButton();
        leftButton.text = "Menu";
        leftButton.verticalAlign = "center";
        addChild(leftButton);

        title = new Text();
        title.text = "RIME";
        title.autoSize = false;
        title.percentWidth = 100;
        title.textAlign = "center";
        addChild(title);

        rightButton = new MenuButton();
        rightButton.text = "Home";
        rightButton.verticalAlign = "center";
        addChild(rightButton);
    }
}