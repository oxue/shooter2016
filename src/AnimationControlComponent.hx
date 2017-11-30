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
	
	public function new() 
	{
		super("anim_control_comp");
	}
	
	override public function load():Void 
	{
		velocity = cast entity.components.get("vel_comp");
		blc = cast entity.components.get("surface2render_comp_c");
	}
	
	private function notMoving():Bool
	{
		return Math.round(velocity.velX) == 0 && Math.round(velocity.velY) == 0;
	}
	
	override public function update():Void 
	{
		if (notMoving())
		{
			if (blc.curAnimaition != 2)
			{
				blc.curAnimaition = 2;
				blc.frame = 0;
			}
		}
		else if (blc.curAnimaition != 3)
		{
			blc.curAnimaition = 3;
			blc.frame = Std.int(Math.random() * 4);
		}
	}
	
}