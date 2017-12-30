package refraction.core;

/**
 * ...
 * @author worldedit
 */

class Component
{
	
	public var remove:Bool;
	public var removeImmediately:Bool;
	public var entity:Entity;

	public function new() 
	{
		
	}
	
	private function setupField(_name:String, _value:Dynamic):Void { }
	
	public function autoSetup(_args:Any):Void
	{
		for(prop in Reflect.fields(_args))
        {
            setupField(prop, Reflect.field(_args, prop));
        }
	}
	
	public function load():Void
	{
		
	}
	
	public function unload():Void
	{
		
	}
	
	public function update():Void
	{
		
	}
	
}