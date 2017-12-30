package refraction.control;
import refraction.core.Component;
import refraction.generic.Position;
import refraction.generic.Velocity;

/**
 * ...
 * @author worldedit
 */

class Damping extends Component
{
	private var velocity:Velocity;
	private var factor:Float;
	
	public function new(_factor:Float = 0.9) 
	{
		factor = _factor;
		super();
	}

	override private function setupField(_name:String, _value:Dynamic):Void
	{
		if(_name == "factor") {
			factor = _value;
		}
	}
	
	override public function load():Void 
	{
		velocity = entity.getComponent(Velocity);
	}
	
	override public function update():Void 
	{
		velocity.velX *= factor;
		velocity.velY *= factor;
	}
	
}