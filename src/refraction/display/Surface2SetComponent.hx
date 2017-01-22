package refraction.display;
import hxblit.Surface2;
import hxblit.TextureAtlas.FloatRect;
import hxblit.TextureAtlas.IntRect;
import refraction.core.Component;

/**
 * ...
 * @author qwerber
 */

class Surface2SetComponent extends Component
{
	public var surfaces:Array<Surface2>;
	public var indexes:Array<Int>;
	public var translateX:Float;
	public var translateY:Float;
	public var frame:FloatRect;
	
	public function new() 
	{
		super("surface2set_comp");
	}
	
	public function addTranslation(x:Float, y:Float):Void
	{
		translateX += x;
		translateY += y;
	}
	
}