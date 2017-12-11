package refraction.core;
//import flash.Vector;

/**
 * ...
 * @author worldedit
 */

class Entity 
{
	public var components:Map<String, Component>;
	public var entities:Array<Entity>;
	
	public function new() 
	{
		components = new Map<String, Component>();
		entities = new Array<Entity>();
	}
	
	public function addEntity(_e:Entity):Void
	{
		entities.push(_e);
	}
	
	public inline function addComponent(_comp:Component):Void
	{
		components.set(_comp.name, _comp);
		_comp.entity = this;
		_comp.load();
	}
	
	public inline function removeComponent(_name:String):Void
	{
		components.get(_name).remove = true;
		components.remove(_name);
	}
	
	public function removeImmediately():Void
	{
		for (comp in components)
		{
			comp.removeImmediately = true;
		}
		for (e in entities)
		{
			e.removeImmediately();
		}
	}
	
	public function remove():Void
	{
		for (comp in components)
		{
			comp.remove = true;
		}
		for (e in entities)
		{
			e.remove();
		}
	}
	
}