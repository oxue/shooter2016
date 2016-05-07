package refraction.core;
import flash.Vector;
import refraction.utils.ObjectPool;

/**
 * ...
 * @author worldedit
 */

class SubSystem<T:ActiveComponent> 
{
	public var components:Vector<T>;
	private var l:Int;
	private var pool:ObjectPool<T>;
	
	public function new() 
	{
		components = new Vector<T>();
		pool = new ObjectPool<T>(10);
	}
	
	public function get():T
	{
		var ret:T = pool.get();
		if(ret!=null)
		addComponent(ret);
		return ret;
	}
	
	public inline function addComponent(_c:T):Void
	{
		components.push(_c);
	}
	
	public function update():Void
	{
		l = components.length;
		var i:Int = 0;
		while (i<l)
		{
			var c:T = components[i];
			if (components[i].removeImmediately)
			{
				pool.alloc(components[i]);
				components[i] = components[--l];
				//components.length --;
				continue;
			}
			c.update();
			if (components[i].remove)
			{
				components[i].removeImmediately = true;
			}
			++i;
		}
		components.length = l;
	}
	
}