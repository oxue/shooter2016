package refraction.generic;
import refraction.core.Component;

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
	
}