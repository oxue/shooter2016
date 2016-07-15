package hxblit;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display3D.Context3DTextureFormat;
import flash.display3D.textures.Texture;
import flash.geom.Point;
import flash.Lib;
import flash.Vector;

/**
 * ...
 * @author worldedit qwerber
 */

class TextureAtlas 
{
	public var bitmaps:Vector<SurfaceData>;
	public var data:BitmapData;
	public var assets:Map<Int,Surface2>;
	public var texture:Texture;
	public var numTextures:Int;
	
	public function new() 
	{
		bitmaps = new Vector<SurfaceData>();
		assets = new Map<Int, Surface2>();
		numTextures = 0;
	}
	
	public function add(_bitmap:BitmapData, _id:Int):Void
	{
		bitmaps.push(new SurfaceData(_bitmap, _id));
		numTextures ++;
	}
	
	public inline function sort():Void
	{
		bitmaps.sort(sortOnWidth);
	}
	
	private inline function sortOnWidth(x:SurfaceData, y:SurfaceData):Int
	{
		if (x.data.width > y.data.width)
		return -1;
		else return 1;
	}
	
	public function pack():Void
	{
		sort();
		var totalWidth:Int = 0;
		var maxHeight:Int = 0;
		var i:Int = bitmaps.length;
		while (i-->0)
		{
			totalWidth += bitmaps[i].data.width;
			if (maxHeight < bitmaps[i].data.height)
			maxHeight = bitmaps[i].data.height;
		}	
		var interval:Int = Math.floor(totalWidth / (Math.sqrt(Math.ceil(totalWidth / maxHeight))));
		i = -1;
		var stepWidth:Int = 0;
		var stepInterval:Int = 1;
		var stops:Vector<Int> = new Vector<Int>();
		while (i++ < bitmaps.length - 1)
		{
			stepWidth += bitmaps[i].data.width;
			if (stepWidth > stepInterval * interval)
			{
				stepInterval ++;
				stops.push(i);
			}
		}
		var size = maxHeight * stepInterval;
		size --;
		size = (size >> 1) | size;
		size = (size >> 2) | size;
		size = (size >> 4) | size;
		size = (size >> 8) | size;
		size = (size >> 16) | size;
		size++;
		data = new BitmapData(size, size, true, 0xffff00ff);
		i = -1;
		var majorX:Int = 0;
		var majorY:Int = 0;
		var p:Point = new Point();
		var j:Int = 0;
		while (i++ < bitmaps.length -1)
		{
			var v:Vector<Float> = new Vector<Float>(8, true);
			p.x = majorX;
			p.y = majorY;
			
			v[0] = (majorX / size);
			v[1] = (majorY / size);

			v[2] = ((majorX +bitmaps[i].data.width) / size);
			v[3] = (majorY / size);

			v[4] = (majorX / size);
			v[5] = ((majorY +bitmaps[i].data.height) / size);

			v[6] = ((majorX +bitmaps[i].data.width) / size);
			v[7] = ((majorY +bitmaps[i].data.height) / size);
			
			var s2:Surface2 = new Surface2();
			s2.atlasCoords = v;
			s2.vx1 = v[0];
			s2.vy1 = v[1];
			s2.vx2 = v[2];
			s2.vy2 = v[3];
			s2.vx3 = v[4];
			s2.vy3 = v[5];
			s2.vx4 = v[6];
			s2.vy4 = v[7];
			s2.width = bitmaps[i].data.width;
			s2.height = bitmaps[i].data.height;
			
			assets.set(bitmaps[i].id, s2);
			
			data.copyPixels(bitmaps[i].data, bitmaps[i].data.rect,p);
			majorX += bitmaps[i].data.width;
			if (j < cast stops.length)
			if (i == stops[j])
			{
				majorX = 0;
				majorY += maxHeight;
				j++;
			}
		}
		texture = HxBlit.context.createTexture(size, size, Context3DTextureFormat.BGRA, false);
		texture.uploadFromBitmapData(data);
		//Lib.current.addChild(new Bitmap(data));
		bitmaps = new Vector<SurfaceData>();
	}	
}