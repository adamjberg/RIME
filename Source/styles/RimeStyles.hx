package styles;

import haxe.ui.toolkit.core.Client;
import haxe.ui.toolkit.core.Screen;
import haxe.ui.toolkit.style.Style;
import haxe.ui.toolkit.style.Styles;
import openfl.filters.DropShadowFilter;
import openfl.Assets;

class RimeStyles extends Styles {
    public function new() {
        super();

        addStyle("Button.expandable", new Style
            (
                {
                    iconPosition: "left"
                }
            )
        );
    }
}