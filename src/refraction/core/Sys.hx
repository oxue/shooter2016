package refraction.core;
import refraction.utils.ObjectPool;
import refraction.core.Entity;
import haxe.Constraints.Constructible;

class NullSystem<T:Component>
{
	public function new()
	{

	}

	@:generic
	public function procure<G:(Constructible<Dynamic>, T)>(e:Entity, _type:Class<G>):G
	{
		var ret:G = new G();
		e.addComponent(ret);
		return ret;
	}
}

/**
 * ...
 * @author worldedit
 */

class Sys<T:Component> 
{
	public var components:Array<T>;
	private var l:Int;
	private var pool:ObjectPool<T>;
	
	public function new() 
	{
		components = new Array<T>();
		pool = new ObjectPool<T>(10);
	}

	@:generic
	public function procure<G:(Constructible<Dynamic>, T)>(e:Entity, _type:Class<G>):G
	{
		var ret:G = new G();
		e.addComponent(ret);
		addComponent(ret);
		return ret;
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