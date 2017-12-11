package refraction.control;
import kha.math.FastVector2;
import refraction.core.Component;
import refraction.core.Application;
import refraction.generic.PositionComponent;
import refraction.generic.VelocityComponent;

/**
 * ...
 * @author worldedit
 */

class KeyControlComponent extends Component
{
	private var position:PositionComponent;
	private var velocity:VelocityComponent;

	public var speed:Float;
	
	public function new(_speed:Float = 5) 
	{
		super("key_con_comp");
		speed = _speed;
	}
	
	override public function load():Void 
	{
		position = cast entity.components.get("pos_comp");
		velocity = cast entity.components.get("vel_comp");
	}
	
	override public function update():Void 
	{
		var acc:FastVector2 = new FastVector2();
		
		if (Application.keys.get("A".charCodeAt(0)))
		acc.x = -1;
		if (Application.keys.get("D".charCodeAt(0)))
		acc.x = 1;
		if (Application.keys.get("W".charCodeAt(0)))
		acc.y = -1;
		if (Application.keys.get("S".charCodeAt(0)))
		acc.y = 1;
		
		acc.normalize();
		acc = acc.mult(speed);
		
		velocity.velX += acc.x;
		velocity.velY += acc.y;
	}
	
}