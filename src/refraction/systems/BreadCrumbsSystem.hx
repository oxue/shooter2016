package refraction.systems;

import haxe.macro.Compiler;
import kha.math.FastVector2;
import refraction.control.BreadCrumbsComponent;
import refraction.core.SubSystem;

/**
 * ...
 * @author 
 */
class BreadCrumbsSystem extends SubSystem<BreadCrumbsComponent>
{
	
	public function new() 
	{
		super();
	}
	
	override public function updateComponent(comp:BreadCrumbsComponent) 
	{
		if (comp.breadcrumbs.length != 0 && comp.breadcrumbs[0] != null)
		{
			var crumb:FastVector2 = comp.breadcrumbs[0];
			var direction:FastVector2 = new FastVector2(crumb.x - comp.position.x, crumb.y - comp.position.y);
			direction.normalize();
			direction = direction.mult(comp.maxAcceleration);
			
			comp.velocity.velX += direction.x;
			comp.velocity.velY += direction.y;
			
			var s = Math.atan2(direction.y, direction.x);
			var targetRotation = s * 57.3;
			var diff = targetRotation - comp.rotation.rotation;
			if (diff < 0) diff += 360;
			if (diff >= 360) diff -= 360;
			if (diff > 180) diff -= 360;
			comp.rotation.rotation += diff / 5;

			var diff = new FastVector2(crumb.x - comp.position.x, crumb.y - comp.position.y);
			if (diff.length < comp.acceptanceRadius){
				comp.breadcrumbs.shift();
			}
		}
	}
	
}