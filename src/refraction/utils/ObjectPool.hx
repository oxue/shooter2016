package refraction.utils;
import flash.Vector;

/**
 * ...
 * @author qwerber
 */

class ObjectPool<T>
{

	public var size:UInt;
	public var pool:Array<T>;
	public var incremental:Int;
	
	public function new(_initialSize:Int, _incremental:Int = 10) 
	{
		pool = new Array<T>();
		incremental = _incremental;
	}
	
	public function get():T
	{
		if (size == 0)
		return null;
		else
		return pool[--size];
	}
	
	public function alloc(_o:T):Void
	{
		pool.push(_o);
	}
	
}