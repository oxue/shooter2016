package refraction.generic;
import refraction.core.Component;

/**
 * ...
 * @author worldedit
 */

class DimensionsComponent extends Component
{
	public var width:Int;
	public var height:Int;
	
	public function new(_width:Int = 20, _height:Int = 20, _name_overrides = "dim_comp") 
	{
		super(_name_overrides);
		width = _width;
		height = _height;
	}
	
}