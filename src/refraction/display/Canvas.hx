package refraction.display;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.BlendMode;
import flash.geom.Rectangle;
import flash.Lib;
import refraction.display.EFLA;

/**
 * ...
 * @author worldedit
 */

class Canvas 
{
	private var displayBitmap:Bitmap;
	public var displayData:BitmapData;
	public var camera:Rectangle;
	
	public function new(_width:Int = 400, _height:Int = 300, _zoom:Int = 2) 
	{
		displayData = new BitmapData(_width, _height);
		displayBitmap = new Bitmap(displayData);
		Lib.current.stage.addChild(displayBitmap).y = -4;
		//displayBitmap.blendMode = BlendMode.MULTIPLY;
		displayBitmap.scaleX = displayBitmap.scaleY = _zoom;
		clear();
		camera = new Rectangle();
	}
	
	public inline function clear(_color = 0x00000000):Void
	{
		displayData.fillRect(displayData.rect, _color);
	}
	
	public inline function lock():Void
	{
		displayData.lock();
	}
	
	public inline function unlock():Void
	{
		displayData.unlock();
	}
	
}