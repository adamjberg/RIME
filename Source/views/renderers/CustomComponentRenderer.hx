package views.renderers;

import haxe.ui.toolkit.core.renderers.ComponentItemRenderer;

class CustomComponentRenderer extends ComponentItemRenderer {

    public function new()
    {
        super();

        style.padding = 10;
    }
}