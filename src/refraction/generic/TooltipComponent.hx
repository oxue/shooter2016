package refraction.generic;
import refraction.core.Component;
import hxblit.TextureAtlas.IntRect;
import refraction.generic.PositionComponent;
import refraction.generic.DimensionsComponent;
import kha.math.Vector2;
import kha.Color;

/**
 * ...
 * @author worldedit
 */

class TooltipComponent extends Component
{
	public var message:String;
	public var camera:IntRect;
	public var position:PositionComponent;
	public var mouseBox:DimensionsComponent;
	public var color:Color;

	public function new(_camera: IntRect, _message = "Default", _color = Color.White)
	{
		message = _message;
		camera = _camera;
		color = _color;
		super("tooltip_comp");
	}

	override public function load():Void 
	{
		position = cast entity.components.get("pos_comp");
		mouseBox = cast entity.components.get("dim_comp");
	}
	
	public function containsPoint(mouseCoords:Vector2):Bool
	{
		var deltaCoords = new Vector2(mouseCoords.x + camera.x - position.x, mouseCoords.y + camera.y - position.y);
		return mouseBox.containsPoint(deltaCoords);
	}
}