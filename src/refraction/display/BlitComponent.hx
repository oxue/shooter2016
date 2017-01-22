package refraction.display;
import flash.display.BitmapData;
import flash.geom.Point;
import refraction.core.ActiveComponent;
import refraction.generic.PositionComponent;
import refraction.generic.TransformComponent;

/**
 * ...
 * @author worldedit
 */

class BlitComponent extends ActiveComponent
{
	
	private var bitmap:BitmapComponent;
	private var position:PositionComponent;
	public var targetCanvas:Canvas;
	
	private var tempPoint:Point;

	public function new() 
	{
		super("blit_comp");
	}
	
	override public function load():Void
	{
		bitmap = cast entity.components.get("bitmap_comp");
		position = cast entity.components.get("pos_comp");
		
		tempPoint = new Point();
	}
	
	override public function update():Void
	{
		tempPoint.x = position.x - targetCanvas.camera.x;
		tempPoint.y = position.y - targetCanvas.camera.y;
		targetCanvas.displayData.copyPixels(bitmap.data, bitmap.data.rect, tempPoint, null, null, true);
	}
	
}