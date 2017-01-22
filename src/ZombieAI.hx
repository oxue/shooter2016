package;

import kha.math.FastVector2;
import refraction.control.BreadCrumbsComponent;
import refraction.core.ActiveComponent;
import refraction.display.Surface2RenderComponentC;
import refraction.generic.PositionComponent;
import refraction.generic.VelocityComponent;
import refraction.tile.TilemapDataComponent;
import refraction.tile.TilemapUtils;
import refraction.utils.Interval;

/**
 * ...
 * @author 
 */
enum ZombieAIState{
	IDLE;
	AGGRESSIVE;
}
 
class ZombieAI extends ActiveComponent
{

	public var breadcrumbs:BreadCrumbsComponent;
	public var randTargetInterval:Interval;
	public var position:PositionComponent;
	public var velocity:VelocityComponent;
	private var blc:Surface2RenderComponentC;
	
	public var followTarget:PositionComponent;
	public var targetMap:TilemapDataComponent;
	
	private var state:ZombieAIState; 
	private var scentInterval:Interval;
	private var lastScene:Bool;
	
	public function new(_name:String, _followTarget:PositionComponent, _targetMap:TilemapDataComponent) 
	{
		super(_name);
		
		followTarget = _followTarget;
		targetMap = _targetMap;
		
		state = IDLE;
		//randTargetInterval = new Interval(walk, 120);
		lastScene = false;
		
		scentInterval = new Interval(dropCrumb, 5); 
	}
	
	function dropCrumb() 
	{
		breadcrumbs.addBreadCrumb(new FastVector2(followTarget.x, followTarget.y));
		if (breadcrumbs.breadcrumbs.length > 50) //TODO: trail length
		{
			//breadcrumbs.breadcrumbs.shift();
		}
	}
	
	function walk() 
	{
		if (breadcrumbs.breadcrumbs[0] == null){
			breadcrumbs.addBreadCrumb(new FastVector2());
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
	//	randTargetInterval.tick();
		
		//AI
		
		
		var p:FastVector2 = new FastVector2(position.x - followTarget.x, position.y - followTarget.y);
		var seen:Bool = !TilemapUtils.raycast(targetMap, position.x + 20, position.y + 20, followTarget.x + 20, followTarget.y + 20) &&
						!TilemapUtils.raycast(targetMap, position.x + 0, position.y + 0, followTarget.x + 0, followTarget.y + 0) &&
						!TilemapUtils.raycast(targetMap, position.x + 20, position.y + 0, followTarget.x + 20, followTarget.y + 0) &&
						!TilemapUtils.raycast(targetMap, position.x + 0, position.y + 20, followTarget.x + 0, followTarget.y + 20);
		
		
		
		if(seen)
		{
			while (breadcrumbs.breadcrumbs.length > 1){
				breadcrumbs.breadcrumbs.shift();
			}
			state = AGGRESSIVE;
			/*var p2:FastVector2 = new FastVector2(position.x - followTarget.x, position.y - followTarget.y);
			p2.normalize();
			p2 = p2.mult(breadcrumbs.maxAcceleration);
			breadcrumbs.breadcrumbs.pop();
			breadcrumbs.breadcrumbs.push(new FastVector2(followTarget.x, followTarget.y));*/
		}
		
		scentInterval.tick();
		
		//ANIMATION
		if (Math.round(velocity.velX) == 0 && Math.round(velocity.velY) == 0)
		{
			blc.curAnimaition = 0;
			blc.frame = 0;
		}else{
			blc.curAnimaition = 1;
		}
	}
	
}