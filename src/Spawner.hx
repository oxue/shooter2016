package ;
import refraction.core.Component;
import refraction.generic.PositionComponent;

/**
 * ...
 * @author qwerber
 */

class Spawner extends Component
{
	
	private var t:Int;
	private var timer:Int;
	
	private var position:PositionComponent;

	public function new() 
	{
		super("spawner_component");
		timer = 100;
		t = 220000;
	}
	
	override public function load():Void 
	{
		position = cast entity.components.get("pos_comp");
	}
	
	override public function update():Void 
	{
		t++;
		if (t >= timer)
		{
			Factory.createZombie(Std.int(position.x), Std.int(position.y));
			t = 0;
		}
	}
	
}