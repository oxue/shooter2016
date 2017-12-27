package refraction.generic;
import refraction.core.Component;
import kha.math.Vector2;
import hxblit.Camera;

/**
 * ...
 * @author worldedit
 */

class RigidAABBComponent extends Component
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
	
	public function drawPoint(camera:Camera, g2:kha.graphics2.Graphics):Void
	{
		g2.color = kha.Color.Green;
		g2.drawRect(
			(x - camera.x + 1) * 2, 
			(y - camera.y - 1) * 2, 
			2, 
			2,
			1.0);
	}
}