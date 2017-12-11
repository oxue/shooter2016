package refraction.generic;
import refraction.core.Component;

/**
 * ...
 * @author worldedit
 */

class TooltipComponent extends Component
{
	public var width:Int;
	public var height:Int;
	
	public function new(_width:Int = 20, _height:Int = 20)
	{
		super("tt_comp");
		width = _width;
		height = _height;
	}
	
}