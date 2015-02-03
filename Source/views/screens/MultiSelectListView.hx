package views.screens; 

import views.renderers.CustomComponentRenderer; 
import haxe.ui.toolkit.core.interfaces.IItemRenderer;
import haxe.ui.toolkit.events.UIEvent;
import openfl.events.MouseEvent;
import haxe.ui.toolkit.core.renderers.ItemRenderer;


class MultiSelectListView extends haxe.ui.toolkit.containers.ListView {

	public function new()
	{
		super(); 

        this.itemRenderer = CustomComponentRenderer;
        this.percentWidth = 100;
        this.percentHeight = 100;
        this._scrollSensitivity = 1;
        _content.style.spacing = 0;
	}

	override private function handleListSelection(item:IItemRenderer, event:UIEvent, raiseEvent:Bool = true):Void {
		var shiftPressed:Bool = false;
		var ctrlPressed:Bool = false;
		
		if (event != null && Std.is(event, MouseEvent)) {
			var mouseEvent:MouseEvent = cast(event, MouseEvent);
			shiftPressed = mouseEvent.shiftKey;
			ctrlPressed = mouseEvent.ctrlKey;
		}
		
		if (ctrlPressed == true) {
			// do nothing
		} else if (shiftPressed == true) {
			
		}
		
		if (isSelected(item)) {
			_selectedItems.remove(item);
			item.state = ItemRenderer.STATE_OVER;
		} else {
			_selectedItems.push(item);
			item.state = ItemRenderer.STATE_SELECTED;
		}

		ensureVisible(item);
		
		if (raiseEvent == true) {
			if (selectedIndex != -1) {
				var item:ItemRenderer = cast _content.getChildAt(selectedIndex);
				if (item != null) {
					item.dispatchProxyEvent(UIEvent.CHANGE, event);
				}
				//var event:UIEvent = new UIEvent(UIEvent.CHANGE);
				//dispatchEvent(event);
			}
		}
	}
}