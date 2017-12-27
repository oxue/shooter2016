package components;

import hxblit.Camera;
import refraction.core.Component;
import refraction.core.Application;
import refraction.core.Utils;
import refraction.generic.DimensionsComponent;
import refraction.generic.PositionComponent;
import refraction.generic.TransformComponent;
import refraction.core.Entity;

/**
 * ...
 * @author 
 */
class InteractComponent extends Component
{
	private var position:PositionComponent;
	private var dimensions:DimensionsComponent;
	private var camera:Camera;
	public var interactFunc:Entity->Void;
	
	public function new(_cam:Camera, _interactFunc:Entity->Void) 
	{
		camera = _cam;
		interactFunc = _interactFunc;
		super("interact_comp");
	}
	
	override public function load():Void 
	{
		position = entity.getComponent("pos_comp", PositionComponent);
		dimensions = entity.getComponent("dim_comp", DimensionsComponent);
	}

	public function containsCursor():Bool
	{
		var worldMouseCoords = Application.mouseCoords().mult(0.5).add(camera.position());
		return dimensions.containsPoint(worldMouseCoords.sub(position.vec()));
	}
	
}