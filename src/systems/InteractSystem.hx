package systems;

import components.InteractComponent;
import refraction.core.Sys;
import refraction.core.Application;

class InteractSystem extends Sys<InteractComponent> {

	override public function update() {
		var hoveredItems = components.filter( function(ic) return ic.containsCursor() );
		if(hoveredItems.length != 0){
			if(Application.mouseIsDown) {
				hoveredItems[0].interactFunc(hoveredItems[0].entity);
			}
		}
	}
}