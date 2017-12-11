package refraction.systems;

import refraction.core.SubSystem;

/**
 * ...
 * @author 
 */
class LightSourceSystem extends SubSystem<>
{

	public function new() 
	{
		super();
	}
	
	override public function updateComponent(comp:) 
	{
		comp.light.position.x = comp.position.x + comp.offset.x;
		comp.light.position.y = comp.position.y + comp.offset.y;
	}
	
}