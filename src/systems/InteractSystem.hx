package systems;

import components.InteractComponent;
import refraction.core.SubSystem;
import refraction.core.Application;

class InteractSystem extends SubSystem<InteractComponent> {

	override public function update() {
		var hoveredItems = components.filter( function(ic) return ic.containsCursor() );
		if(hoveredItems.length != 0){
			if(Application.mouseIsDown) {
				hoveredItems[0].interactFunc(hoveredItems[0].entity);
			}
		}
	}
}