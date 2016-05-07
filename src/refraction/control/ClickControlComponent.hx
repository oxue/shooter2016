package refraction.control;
import flash.events.MouseEvent;
import refraction.core.ActiveComponent;
import refraction.core.Application;
import refraction.generic.PositionComponent;

/**
 * ...
 * @author worldedit
 */

class ClickControlComponent extends ActiveComponent
{
	private var position:PositionComponent;
	
	public function new() 
	{
		super("click_con_comp");
	}
	
	override public function load():Void 
	{
		position = cast entity.components.get("pos_comp");
	}
	
	public function move():Void 
	{
		position.oldX = position.x;
		position.oldY = position.y;
		position.x = Application.mouseX;
		position.y = Application.mouseY;
	}
	
}