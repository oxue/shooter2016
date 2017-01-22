package refraction.ds2d;

import flash.display.BitmapData;
import flash.display.GradientType;
import flash.display.Shape;
import flash.display.Sprite;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Vector3D;
/**
 * ...
 * @author werber
 */
class LightSource 
{
	public var x:Int;
	public var y:Int;
	
	public var radius:Int;
	public var color:Int;
	
	public var cache:BitmapData;
	private var lightTexture:BitmapData;
	private var tempPoint:Point;
	
	public var lastX:Int;
	public var lastY:Int;
	
	public var remove:Bool;
	
	public var v3Color:Vector3D;
	
	public function new(_x:Int=0, _y:Int=0, _color:Int=0xff0000, _radius:Int = 100) 
	{
		x = _x;
		y = _y;
		
		radius = _radius;
		color = _color;
		
		cache = new BitmapData(radius * 2, radius * 2, true, 0x00000000);
		lightTexture = new BitmapData(radius * 2, radius * 2, true, 0x00000000);
		var s:Shape = new Shape();
		var m:Matrix = new Matrix();
		m.createGradientBox(radius * 2, radius * 2);
		s.graphics.beginGradientFill(GradientType.RADIAL, [0xffffff,color, 0], [1, 1, 0], [0, 10, 255],m);
		s.graphics.drawCircle(radius, radius, radius);
		cache.draw(s);
		lightTexture.draw(s);
		
		tempPoint = new Point();
		
		var r:Int = color >> 16;
		var g:Int = (color >> 8) - (r << 8);
		var b:Int = color - (r << 16) - (g << 8);
		v3Color = new Vector3D(r / 255, g / 255, b / 255, 1);
		
	}
	
	public inline function clear():Void
	{
		cache.copyPixels(lightTexture, lightTexture.rect, tempPoint);
	}
	
}

