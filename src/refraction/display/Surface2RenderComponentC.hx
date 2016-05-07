package refraction.display;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.Vector;
import hxblit.HxBlit;
import refraction.core.ActiveComponent;
import refraction.generic.PositionComponent;
import refraction.generic.TransformComponent;

/**
 * ...
 * @author worldedit
 */

class Surface2RenderComponentC extends ActiveComponent
{

	public var frameTime:Int;
	private var time:Int;
	public var frame:Int;
	public var animations:Vector<Array<Int>>;
	private var bound:Rectangle;
	private var surface2Set:Surface2SetComponent;
	private var transform:TransformComponent;
	private var position:PositionComponent;
	public var numRot:Int;
	public var curAnimaition:Int;
	public var targetCanvas:Canvas;
	
	public function new() 
	{
		super("surface2render_comp_c");
		numRot = 33;
	}
	
	override public function load():Void 
	{
		surface2Set = cast entity.components.get("surface2set_comp");
		transform = cast entity.components.get("trans_comp");
		position = cast entity.components.get("pos_comp");
		bound = new Rectangle(0, 0, surface2Set.frame.width, surface2Set.frame.height);
		animations = new Vector<Array<Int>>();
		animations.push([0,0, 0,1, 2,1]);
		frameTime = 4;
		//time = cast Math.random() * frameTime;
		frame = cast Math.random() * 5;
	}
	
	override public function update():Void 
	{
		time++;
		if (time == frameTime)
		{
			time = 0;
			frame ++;
			if (frame == animations[curAnimaition].length)
			{
				frame = 0;
			}
			bound.y = animations[curAnimaition][frame];
		}
		if (transform.rotation < 0)
		{
			transform.rotation += 360;
		}else if (transform.rotation >= 360)
		{
			transform.rotation -= 360;
		}
		bound.x = Math.round(transform.rotation /360* (numRot-1));
		HxBlit.blit(surface2Set.surfaces[cast bound.x + bound.y * numRot],
					cast (Math.round(position.x - surface2Set.translateX) - targetCanvas.camera.x),
					cast (Math.round(position.y - surface2Set.translateY) - targetCanvas.camera.y));
					
		//trace(0);
	}
	
}