package refraction.tile;

/**
 * ...
 * @author worldedit
 */

 
class CollisionData 
{
	public var nature:Int;
	public var collided:Bool;
	public var time:Float;
	
	public inline static var horizontal:Int = 0;
	public inline static var vertical:Int = 1;
	
	public function new(_collided:Bool, _time:Float = 0, _nature:Int = 0) 
	{
		collided = _collided;
		nature = _nature;
		time = _time;
	}
	
}