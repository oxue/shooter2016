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
class InteractComponent extends Component
{
	private var position:PositionComponent;
	private var dimensions:DimensionsComponent;
	private var camera:IntRect;
	private var interactFunc:Void->Void;
	
	public function new(_cam:IntRect, _interactFunc:Void->Void) 
	{
		camera = _cam;
		interactFunc = _interactFunc;
		super("interact_comp");
	}
	
	override public function load():Void 
	{
		position = cast entity.components.get("pos_comp");
		dimensions = cast(entity.components.get("dim_comp"), DimensionsComponent);
	}
	
	public function interact():Void
	{
		
	}
	
	public function showInteractStatus():Void
	{
		
	}
	
	override public function update():Void 
	{
		var wm:PositionComponent = new PositionComponent(Application.mouseX / 2 + camera.x - dimensions.width/2, Application.mouseY / 2 + camera.y - dimensions.height/2);
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
		
	}
	
}