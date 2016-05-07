package hxblit;
import flash.display.BitmapData;

/**
 * ...
 * @author worldedit qwerber
 */

class SurfaceData 
{
	public var data:BitmapData;
	public var id:Int;
	
	public function new(_data:BitmapData, _id:Int) 
	{
		data = _data;
		id = _id;
	}
	
}