package views;

import haxe.ui.toolkit.containers.Container;
import haxe.ui.toolkit.controls.Button;
import haxe.ui.toolkit.controls.Text;
import msignal.Signal.Signal0;
import openfl.events.MouseEvent;
import openfl.filters.DropShadowFilter;

class HeaderBar extends Container {

    public var onBackPressed:Signal0 = new Signal0();

    private var backButton:Button;
    private var title:Text;

    public function new() {
        super();
        this.percentWidth = 100;
        this.style.backgroundColor = 0xdfdddd;
        this.style.filter = new DropShadowFilter(2, 90, 0x808080, 1, 0, 4, 1, 3);
        this.autoSize = true;
        this.style.padding = 5;
    }

    override public function initialize()
    {
        super.initialize();

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
        title.verticalAlign = "center";
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