package refraction.core;
//import flash.Vector;
import haxe.ds.Vector;
import refraction.utils.ObjectPool;

/**
 * ...
 * @author worldedit
 */

class SubSystem<T:Component> 
{
	public var components:Array<T>;
	private var l:Int;
	private var pool:ObjectPool<T>;
	
	public function new() 
	{
		components = new Array<T>();
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
	
	public function updateComponent(comp:T){
		// abstract function
		comp.update();
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
				continue;
			}
			updateComponent(c);
			if (components[i].remove)
			{
				components[i].removeImmediately = true;
			}
			++i;
		}
		while (components.length > l){
			components.pop();
		}
	}
	
}