package;

import hxblit.TextureAtlas.IntRect;
import refraction.core.Component;
import refraction.core.Application;
import refraction.core.Utils;
import refraction.generic.DimensionsComponent;
import refraction.generic.PositionComponent;
import refraction.generic.TransformComponent;

/**
 * ...
 * @author 
 */
class NPCComponent extends Component
{
	private var position:PositionComponent;
	private var dimensions:DimensionsComponent;
	private var targetCamera:IntRect;
	private var statusText:StatusText;
	
	public function new(_cam:IntRect, _statusText:StatusText) 
	{
		targetCamera = _cam;
		statusText = _statusText;
		super("npc_comp");
	}
	
	override public function load():Void 
	{
		position = cast entity.components.get("pos_comp");
		dimensions = cast(entity.components.get("dim_comp"), DimensionsComponent);
	}
	
	public function interact():Void
	{
		statusText.text = "interacting";
	}
	
	public function showInteractStatus():Void
	{
		statusText.text = "mimi lmb to talk";
	}
	
	override public function update():Void 
	{
		var wm:PositionComponent = new PositionComponent(Application.mouseX / 2 + targetCamera.x - dimensions.width/2, Application.mouseY / 2 + targetCamera.y - dimensions.height/2);
		var dist:Float = Utils.posDis2(position, wm);
		if (dist < dimensions.width / 2 * dimensions.height / 2)
		{
			showInteractStatus();
			if (Application.mouseIsDown){
				interact();
			}
		}else{
			removeInteractStatus();
		}
	}
	
	public function removeInteractStatus() 
	{
		statusText.text = "";
	}
	
}