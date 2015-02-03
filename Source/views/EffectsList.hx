package views; 

import controllers.ScreenManager; 
import views.controls.ListView;  
import controllers.EffectController; 
import models.effects.Effect; 
import views.renderers.CustomComponentRenderer;

class EffectsList extends ListView {

        private var effectController:EffectController;
        private var effectList:Array<Effect>; 

	public function new(?effectController:EffectController){

        	super(); 

                this.effectController = effectController; 
                this.effectList = effectController.effects; 

                effectController.onUpdated.add(populate); 
                populate(); 
	}


        private function populate()
        {
                dataSource.removeAll(); 

                var pos:Int = 0; 
                for(effect in effectList)
                {
                        dataSource.add(
                        {
                                text: effect.name,
                                subtext: effect.mediaProperties,
                                componentType: "button",
                                componentValue: "delete" 
                        }); 
                        var item:CustomComponentRenderer = cast(getItem(pos++), CustomComponentRenderer);
                        item.component.onClick = function(e){
                                deleteEffect(effect); 
                        };
                }
        }

        private function deleteEffect(effect:Effect)
        {
                effectController.deleteEffect(effect); 
        }
        
}