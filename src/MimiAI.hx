package;

import kha.math.FastVector2;
import refraction.control.BreadCrumbsComponent;
import refraction.core.ActiveComponent;
import refraction.display.Surface2RenderComponentC;
import refraction.generic.PositionComponent;
import refraction.generic.VelocityComponent;
import refraction.utils.Interval;

/**
 * ...
 * @author 
 */
class MimiAI extends ActiveComponent
{

	public var breadcrumbs:BreadCrumbsComponent;
	public var randTargetInterval:Interval;
	public var position:PositionComponent;
	public var velocity:VelocityComponent;
	private var blc:Surface2RenderComponentC;
	
	public function new(_name:String) 
	{
		super(_name);
		randTargetInterval = new Interval(walk, 120);
	}
	
	function walk() 
	{
		if (breadcrumbs.breadcrumbs[0] == null){
			breadcrumbs.breadcrumbs.push(new FastVector2());
		}
		
		breadcrumbs.breadcrumbs[0].x = position.x + Math.random() * 300 - 150;
		breadcrumbs.breadcrumbs[0].y = position.x + Math.random() * 300 - 150;
	}

	override public function load():Void 
	{
		breadcrumbs = cast entity.components.get("BreadCrumbsComponent");
		position = cast entity.components.get("pos_comp");
		velocity = cast entity.components.get("vel_comp");
		blc = cast entity.components.get("surface2render_comp_c");
	}
	
	override public function update():Void 
	{
		randTargetInterval.tick();
		if (Math.round(velocity.velX) == 0 && Math.round(velocity.velY) == 0)
		{
			blc.curAnimaition = 0;
			blc.frame = 0;
		}else{
			blc.curAnimaition = 1;
		}
	}
	
}