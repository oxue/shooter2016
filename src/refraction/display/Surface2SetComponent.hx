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
	public var registrationX:Float;
	public var registrationY:Float;
	public var frame:FloatRect;
	
	public function new()
	{
		super();
		registrationX = registrationY = 0;
	}
	
	public function addTranslation(x:Float, y:Float):Surface2SetComponent
	{
		translateX += x;
		translateY += y;
		return this;
	}
	
	public function registration(x:Float, y:Float):Surface2SetComponent
	{
		registrationX = x;
		registrationY = y;
		return this;
	}
	
}