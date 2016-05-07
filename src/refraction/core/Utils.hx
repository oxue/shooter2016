package refraction.core;
import refraction.generic.PositionComponent;

/**
 * ...
 * @author worldedit
 */

class Utils 
{

	public static inline function posDis2(_pos1:PositionComponent, _pos2:PositionComponent):Float
	{
		var dx:Float = _pos1.x - _pos2.x;
		var dy:Float = _pos1.y - _pos2.y;
		
		var dis:Float = dx * dx + dy * dy;
		return dis;
	}
	
	public static inline function f2(_x:Float):Float
	{
		return _x * _x;
	}
	
}