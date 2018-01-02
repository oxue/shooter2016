package refraction.generic;
import refraction.core.Component;
import refraction.core.Utils;

/**
 * ...
 * @author worldedit
 */

class Velocity extends Component
{
	
	private var position:Position;
	public var velX:Float;
	public var velY:Float;

	public function new() 
	{
		velX = velY = 0;
		super();
	}
	
	override public function load():Void 
	{
		position = entity.getComponent(Position);
	}
	
	override public function update():Void 
	{
		position.x += velX;
		position.y += velY;
	}
	
	public function interpolate(speed:Float) 
	{
		var len = Math.sqrt(Utils.f2(velX) + Utils.f2(velY));
		if (len < speed){
			return;
		}
		velX = velX / len * speed; 
		velY = velY / len * speed;
		trace(velX);
	}
	
}