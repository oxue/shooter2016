package ;
import refraction.core.ActiveComponent;
import refraction.display.Surface2RenderComponentC;
import refraction.generic.VelocityComponent;

/**
 * ...
 * @author worldedit
 */

class AnimationControlComponent extends ActiveComponent
{
	private var velocity:VelocityComponent;
	private var blc:Surface2RenderComponentC;
	public var blc2:Surface2RenderComponentC;

	private var inventory:InventoryComponent;
	
	public function new() 
	{
		super("anim_control_comp");
	}
	
	override public function load():Void 
	{
		velocity = cast entity.components.get("vel_comp");
		blc = cast entity.components.get("surface2render_comp_c");
		inventory = cast entity.components.get("inventory_comp");
	}
	
	private function notMoving():Bool
	{
		return Math.round(velocity.velX) == 0 && Math.round(velocity.velY) == 0;
	}
	
	override public function update():Void 
	{
		var idle_animation = inventory.wieldingWeapon() ? 2 : 0;
		var walking_animation = idle_animation + 1;

		if (notMoving())
		{
			if (blc.curAnimaition != idle_animation)
			{
				blc.curAnimaition = idle_animation;
				blc.frame = 0;
			}
		}
		else if (blc.curAnimaition != walking_animation)
		{
			blc.curAnimaition = walking_animation;
			blc.frame = Std.int(Math.random() * 4);
		}
	}
	
}