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
	
	override public function update():Void 
	{
		var worldMouseCoords = Application.mouseCoords().mult(0.5).add(camera.position());

		if(dimensions.containsPoint(worldMouseCoords.sub(position.vec()))){
			trace("...");
		}
	}
	
}