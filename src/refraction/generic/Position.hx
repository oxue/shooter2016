package refraction.generic;
import refraction.core.Component;
import kha.math.Vector2;
import hxblit.Camera;

/**
 * ...
 * @author worldedit
 */

class Position extends Component
{
	public var x:Float;
	public var y:Float;
	
	public var rotation:Float;
	public var registration:Vector2;
	
	public function new(_x:Float = 0, _y:Float = 0, _rx:Float = 0, _ry:Float = 0, _rotation:Float = 0) 
	{
		x = _x;
		y = _y;
		rotation = _rotation;
		registration = new Vector2(_rx, _ry);
		super();
	}

	override public function autoParams(_args:Dynamic):Void
	{
		x = _args.x;
		x = _args.y;
	}

	public function vec():Vector2
	{
		return new Vector2(x, y);
	}
	
	public function toString():String
	{
		return "<" + x + " " + y + ">\n";
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