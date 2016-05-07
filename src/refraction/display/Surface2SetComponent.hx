package refraction.display;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.Lib;
import flash.Vector;
import flash.Vector;
import hxblit.HxBlit;
import hxblit.Surface2;
import refraction.core.Component;

/**
 * ...
 * @author qwerber
 */

class Surface2SetComponent extends Component
{
	public var surfaces:Vector<Surface2>;
	public var indexes:Vector<Int>;
	public var translateX:Float;
	public var translateY:Float;
	public var frame:Rectangle;
	
	public function new() 
	{
		super("surface2set_comp");
	}
	
	public function splitNIndex(_data:BitmapData, _frame:Rectangle):Void
	{
		frame = _frame;
		var gw:Int = cast _data.width / _frame.width;
		var gh:Int = cast _data.height / _frame.height;
		var i:Int = -1;
		var startInd:Int = HxBlit.atlas.numTextures;
		indexes = new Vector<Int>();
		translateX = translateY = 0;
		//Lib.current.addChild(new Bitmap(_data)).y = 100;
		while (i++ < gh - 1)
		{
			var j:Int = -1;
			while (j++ < gw - 1)
			{
				var b:BitmapData = new BitmapData(cast _frame.width, cast _frame.height, true, 0);
				_frame.x = j * _frame.width;
				_frame.y = i * _frame.height;
				b.copyPixels(_data, _frame, new Point(), null, null, true);
				HxBlit.atlas.add(b, startInd + i * gw + j);
				indexes.push(startInd + i * gw + j);
			}
		}
	}
	
	/**
	 * Only call this function after a single Atlas::pack() has been called!
	 */
	public function assignTextures():Void
	{
		var i:Int = indexes.length;
		surfaces = new Vector<Surface2>(indexes.length,true);
		while (i-->0)
		{
			surfaces[i] = HxBlit.atlas.assets.get(indexes[i]);
		}
	}
	
}