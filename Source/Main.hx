package;

import haxe.ui.toolkit.core.Root;
import haxe.ui.toolkit.core.Toolkit;
import haxe.ui.toolkit.themes.GradientMobileTheme;
import openfl.display.Sprite ;

class Main extends Sprite {

	public function new () {
        super();
		Toolkit.theme = new GradientMobileTheme();
		Toolkit.init();
		Toolkit.openFullscreen(function(root:Root) {
			var app:App = new App();
			root.addChild(app);
		});
	}
}