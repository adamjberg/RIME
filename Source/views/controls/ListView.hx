package views.controls;

import views.renderers.CustomComponentRenderer;

class ListView extends haxe.ui.toolkit.containers.ListView {

    public function new()
    {
        super();

        this.itemRenderer = CustomComponentRenderer;
        this.percentWidth = 100;
        this.percentHeight = 100;
        this._scrollSensitivity = 1;
        _content.style.spacing = 0;
    }
}