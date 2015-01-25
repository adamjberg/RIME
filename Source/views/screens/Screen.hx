package views.screens;

import haxe.ui.toolkit.containers.VBox;
import msignal.Signal.Signal0;

class Screen extends VBox {

    public var onClosed:Signal0 = new Signal0();

    public function new()
    {
        super();
        percentWidth = 100;
        percentHeight = 100;
    }
}