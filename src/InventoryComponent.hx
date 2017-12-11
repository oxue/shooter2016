package ;
import refraction.core.Component;
import refraction.core.Application;

/**
 * ...
 * @author worldedit
 */

class InventoryComponent extends Component
{
	
	public function new() 
	{
		super("inventory_comp");
	}
	
	override public function load():Void 
	{
		
	}
	
	override public function update():Void 
	{		
	
	}
	
	public function wieldingWeapon():Bool
	{
		return Application.mouseIsDown;
	}
}