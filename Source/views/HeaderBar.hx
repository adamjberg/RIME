package views;

import haxe.ui.toolkit.containers.MenuBar;
import haxe.ui.toolkit.controls.Button;
import haxe.ui.toolkit.controls.Text;
import msignal.Signal.Signal0;
import openfl.events.MouseEvent;

class HeaderBar extends MenuBar {

    public var onBackPressed:Signal0 = new Signal0();

    private var backButton:Button;
    private var title:Text;

    public function new() {
        super();

        this.percentWidth = 100;
        this.style.paddingLeft = 5;

        backButton = new Button();
        backButton.text = "Back";
        backButton.verticalAlign = "center";
        addChild(backButton);
        hideBackButton();

        title = new Text();
        title.style.fontSize = 40;
        title.text = "RIME";
        title.autoSize = false;
        title.percentWidth = 100;
        title.percentHeight = 100;
        title.horizontalAlign = "center";
        title.textAlign = "center";
        addChild(title);

        backButton.addEventListener(MouseEvent.CLICK, backButtonPressed);
    }

    public function showBackButton()
    {
        backButton.visible = true;
    }

    public function hideBackButton()
    {
        backButton.visible = false;
    }

    private function backButtonPressed(event:MouseEvent)
    {
        onBackPressed.dispatch();
    }
}