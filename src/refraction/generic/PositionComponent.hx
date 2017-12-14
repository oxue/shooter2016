package refraction.generic;
import refraction.core.Component;
import kha.math.Vector2;

/**
 * ...
 * @author worldedit
 */

class PositionComponent extends Component
{
	public var x:Float;
	public var y:Float;
	
	public var oldX:Float;
	public var oldY:Float;
	
	public function new(_x:Float = 0, _y:Float = 0) 
	{
		oldX = x = _x;
		oldY = y = _y;
		super("pos_comp");
	}

	public function vec():Vector2
	{
		return new Vector2(x, y);
	}
	
	public function toString():String
	{
		return "<" + x + " " + y + ">/<" + oldX + " " + oldY + ">\n";
	}
	
}