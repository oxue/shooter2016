package refraction.generic;
import refraction.core.ActiveComponent;

/**
 * ...
 * @author qwerber
 */

class TimeRemoverComponent extends ActiveComponent
{
	private var t:Int;
	private var timer:Int;
	
	public function new(_timer:Int) 
	{
		timer = _timer;
		super("time_remover_comp");
	}
	
	override public function update():Void 
	{
		t++;
		if (t > timer)
		entity.removeImmediately();
	}
	
}