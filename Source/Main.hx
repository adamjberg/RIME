package;

import haxe.ui.toolkit.containers.ExpandablePanel;
import haxe.ui.toolkit.containers.Accordion;
import haxe.ui.toolkit.containers.Stack;
import haxe.ui.toolkit.controls.popups.Popup;
import haxe.ui.toolkit.core.Root;
import haxe.ui.toolkit.core.Toolkit;
import haxe.ui.toolkit.style.Style;
import haxe.ui.toolkit.style.StyleManager;
import haxe.ui.toolkit.themes.GradientMobileTheme;
import styles.RimeStyles;
import openfl.display.Sprite ;

class Main extends Sprite {



    public function new () {
        super();
        SensorExtension.init();
        Toolkit.theme = new GradientMobileTheme();
        Toolkit.setTransitionForClass(Stack, "none");
        Toolkit.setTransitionForClass(Accordion, "none");
        Toolkit.setTransitionForClass(ExpandablePanel, "none");
        Toolkit.setTransitionForClass(Popup, "none");
        Toolkit.init();
        Toolkit.openFullscreen(function(root:Root) {
            StyleManager.instance.addStyles(new RimeStyles());
            var app:App = new App();
            root.addChild(app);
        });
    }

}