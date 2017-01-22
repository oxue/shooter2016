package refraction.control;
import refraction.core.ActiveComponent;
import refraction.core.Application;
import refraction.generic.PositionComponent;
import refraction.generic.TransformComponent;

/**
 * ...
 * @author worldedit
 */

class RotationControlComponent extends ActiveComponent
{
	
	private var transform:TransformComponent;
	private var position:PositionComponent;

	public function new() 
	{
		super("rot_con_comp");
	}
	
	override public function load():Void 
	{
		transform = cast entity.components.get("trans_comp");
		position = cast entity.components.get("pos_comp");
	}
	
	override public function update():Void 
	{
		transform.rotation = 
			cast (Math.atan2(
				(Application.mouseY / 2) - position.y - 10 + cast(Application.currentState, GameState).canvas.camera.y,
				(Application.mouseX / 2) - position.x - 10 + cast(Application.currentState, GameState).canvas.camera.x) * 180 / 3.14);
	}
	
}