package styles;

import haxe.ui.toolkit.core.Client;
import haxe.ui.toolkit.core.PopupManager;
import haxe.ui.toolkit.core.Screen;
import haxe.ui.toolkit.core.Toolkit;
import haxe.ui.toolkit.style.Style;
import haxe.ui.toolkit.style.Styles;
import openfl.filters.DropShadowFilter;
import openfl.Assets;

class RimeStyles extends Styles {
    public function new() {
        super();

        PopupManager.instance.defaultWidth = Math.round((Client.instance.windowWidth * 0.9) / Toolkit.scaleFactor);

        addStyle("Button.expandable", new Style
            (
                {
                    iconPosition: "left"
                }
            )
        );
        addStyle("ListSelector", new Style
            (
                {
                    iconPosition: "right"
                }
            )
        );
    }
}