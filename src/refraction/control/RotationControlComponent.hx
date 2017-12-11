package refraction.control;
import hxblit.TextureAtlas.IntRect;
import refraction.core.Component;
import refraction.core.Application;
import refraction.generic.PositionComponent;
import refraction.generic.TransformComponent;

/**
 * ...
 * @author worldedit
 */

class RotationControlComponent extends Component
{
	
	private var transform:TransformComponent;
	private var position:PositionComponent;
	private var targetRotation:Float;
	private var targetCamera:IntRect;

	public function new(_cam:IntRect) 
	{
		targetCamera = _cam;
		targetRotation = 0;
		super("rot_con_comp");
	}
	
	override public function load():Void 
	{
		transform = cast entity.components.get("trans_comp");
		position = cast entity.components.get("pos_comp");
	}
	
	override public function update():Void 
	{
		targetRotation = 
			cast (Math.atan2(
				(Application.mouseY / 2) - position.y - 10 + targetCamera.y,
				(Application.mouseX / 2) - position.x - 10 + targetCamera.x) * 180 / 3.14);
				
		var diff = targetRotation - transform.rotation;
		if (diff < 0) diff += 360;
		if (diff >= 360) diff -= 360;
		if (diff > 180) diff -= 360;
		transform.rotation += diff / 5;
	}
	
}