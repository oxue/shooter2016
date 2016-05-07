package ;
import refraction.core.ActiveComponent;
import refraction.display.BlitComponentC;
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
	
	override public function update():Void 
	{
		if (blc.curAnimaition != 1)
		{
			blc.curAnimaition = 1;
			blc.frame = cast Math.random() * 4;
			if (blc2.curAnimaition == 0 || blc2.curAnimaition == 1)
			{
				blc2.curAnimaition = 0;
				blc2.frame = blc.frame;
			}
		}
		if (Math.round(velocity.velX) == 0 && Math.round(velocity.velY) == 0)
		{
			if (blc.curAnimaition != 0)
			{
				blc.curAnimaition = 0;
				blc.frame = 0;
				if (blc2.curAnimaition == 0 || blc2.curAnimaition == 1)
				{
					blc2.curAnimaition = 1;
					blc2.frame = 0;
				}
			}
		}
	}
	
}