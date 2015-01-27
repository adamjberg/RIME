package views; 

import controllers.ScreenManager; 
import haxe.ui.toolkit.containers.ScrollView; 
import haxe.ui.toolkit.containers.VBox; 

class EffectsList extends ScrollView {

	private var vBox:VBox; 

	public function new(){
		super(); 

		this._scrollSensitivity = 1;
        this.style.borderSize = 0;
        this.style.spacingY = 10;
        this.percentWidth = 95;
        this.horizontalAlign = "center";
        
        vBox = new VBox();
        vBox.percentWidth = 100;
        addChild(vBox);
	}
}