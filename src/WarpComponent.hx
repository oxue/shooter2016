package ;
import refraction.core.Component;
import refraction.core.Application;
import refraction.generic.PositionComponent;

/**
 * ...
 * @author worldedit
 */

class WarpComponent extends Component
{

	private var position:PositionComponent;
	public var level:String;
	public var target:PositionComponent;
	
	public function new() 
	{
		super("warp_comp");
	}
	
	override public function load():Void 
	{
		position = cast entity.components.get("pos_comp");
	}
	
	override public function update():Void 
	{
		var dx:Float = position.x - target.x;
		var dy:Float = position.y - target.y;
		var dis2:Float = dx * dx + dy * dy;
		if (dis2 < 160)
		{
			cast(Application.currentState, GameState).loadLevel(level);
		}
	}
	
}