package refraction.display;

import hxblit.KhaBlit;
import hxblit.TextureAtlas.FloatRect;
import hxblit.TextureAtlas.IntRect;
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
	public var animations:Array<Array<Int>>;
	private var coordX:Int;
	private var coordY:Int;
	private var surface2Set:Surface2SetComponent;
	private var transform:TransformComponent;
	private var position:PositionComponent;
	public var numRot:Int;
	public var curAnimaition:Int;
	public var targetCamera:IntRect;
	
	public function new() 
	{
		super("surface2render_comp_c");
		numRot = 32;
	}
	
	override public function load():Void 
	{
		surface2Set = cast entity.components.get("surface2set_comp");
		transform = cast entity.components.get("trans_comp");
		position = cast entity.components.get("pos_comp");
		coordX = coordY = 0;
		animations = new Array<Array<Int>>();
		animations.push([0,0, 0,1, 2,1]);
		frameTime = 4;
		curAnimaition = 0;
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
			coordY = animations[curAnimaition][frame];
		}
		if (transform.rotation < 0)
		{
			transform.rotation += 360;
		}else if (transform.rotation >= 360)
		{
			transform.rotation -= 360;
		}
		coordX = Math.round(transform.rotation / 360 * numRot) % numRot;
		KhaBlit.blit(surface2Set.surfaces[cast coordX + coordY * numRot],
					cast (Math.round(position.x - surface2Set.translateX) - targetCamera.x),
					cast (Math.round(position.y - surface2Set.translateY) - targetCamera.y));
	}
	
}