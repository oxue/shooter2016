package refraction.ds2d;
import refraction.core.ActiveComponent;
import refraction.core.Component;
import refraction.generic.PositionComponent;

/**
 * ...
 * @author qwerber
 */

class Circle extends ActiveComponent
{

	public var x:Float;
	public var y:Float;
	public var radius:Float;
	public var position:PositionComponent;
	
	public function new(_x:Float, _y:Float, _radius:Float) 
	{
		x = _x;
		y = _y;
		radius = _radius;
		super("circle_comp");
	}
	
	override public function load():Void 
	{
		position = cast entity.components.get("pos_comp");
	}
	
}