package refraction.generic;
import refraction.core.ActiveComponent;

/**
 * ...
 * @author worldedit
 */

class VelocityComponent extends ActiveComponent
{
	
	private var position:PositionComponent;
	public var velX:Float;
	public var velY:Float;

	public function new() 
	{
		velX = velY = 0;
		super("vel_comp");
	}
	
	override public function load():Void 
	{
		position = cast entity.components.get("pos_comp");
	}
	
	override public function update():Void 
	{
		position.oldX = position.x;
		position.oldY = position.y;
		position.x += velX;
		position.y += velY;
	}
	
}