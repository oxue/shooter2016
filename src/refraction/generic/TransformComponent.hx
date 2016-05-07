package refraction.generic;
import refraction.core.Component;

/**
 * ...
 * @author worldedit
 */

class TransformComponent extends Component
{
	public var rotation:Float;
	
	public function new() 
	{
		rotation = 0;
		super("trans_comp");
	}
	
}