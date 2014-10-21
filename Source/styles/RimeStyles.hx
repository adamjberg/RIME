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

        var f = Assets.getFont("fonts/Oxygen.ttf");
        var fb = Assets.getFont("fonts/Oxygen-Bold.ttf");

        addStyle("Text", new Style( {
            fontSize: 40,
            fontName: f.fontName,
            fontEmbedded: true,
            color: 0x444444
        } ));

        addStyle("TextInput", new Style( {
            fontSize: 40,
            fontName: f.fontName,
            fontEmbedded: true,
            color: 0x444444
        } ));
    }
}