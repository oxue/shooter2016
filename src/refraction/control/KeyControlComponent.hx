package refraction.control;
import flash.ui.Keyboard;
import refraction.core.ActiveComponent;
import refraction.core.Application;
import refraction.generic.PositionComponent;
import refraction.generic.VelocityComponent;

/**
 * ...
 * @author worldedit
 */

class KeyControlComponent extends ActiveComponent
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
		if (Application.keys.get(Keyboard.A))
		velocity.velX += -speed;
		if (Application.keys.get(Keyboard.D))
		velocity.velX += speed;
		if (Application.keys.get(Keyboard.W))
		velocity.velY += -speed;
		if (Application.keys.get(Keyboard.S))
		velocity.velY += speed;
	}
	
}