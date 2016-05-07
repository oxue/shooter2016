package refraction.control;
import refraction.core.ActiveComponent;
import refraction.generic.PositionComponent;
import refraction.generic.VelocityComponent;

/**
 * ...
 * @author worldedit
 */

class DampingComponent extends ActiveComponent
{
	private var velocity:VelocityComponent;
	private var factor:Float;
	
	public function new(_factor:Float = 0.9) 
	{
		factor = _factor;
		super("damp_comp");
	}
	
	override public function load():Void 
	{
		velocity = cast entity.components.get("vel_comp");
	}
	
	override public function update():Void 
	{
		velocity.velX *= factor;
		velocity.velY *= factor;
	}
	
}