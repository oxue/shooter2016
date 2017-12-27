package ;
import refraction.core.Component;
import refraction.display.Surface2RenderComponentC;
import refraction.generic.VelocityComponent;

/**
 * ...
 * @author worldedit
 */

class AnimationControlComponent extends Component
{
	private var velocity:VelocityComponent;
	private var blc:Surface2RenderComponentC;
	public var weapons:Surface2RenderComponentC;

	private var inventory:InventoryComponent;
	
	public function new() 
	{
		super("anim_control_comp");
	}
	
	override public function load():Void 
	{
		velocity = entity.getComponent("vel_comp", VelocityComponent);
		blc = entity.getComponent("surface2render_comp_c", Surface2RenderComponentC);
		weapons = entity.getComponent("weapon_render_comp", Surface2RenderComponentC);
		inventory = entity.getComponent("inventory_comp", InventoryComponent);
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