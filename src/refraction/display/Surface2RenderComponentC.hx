package refraction.display;

import hxblit.KhaBlit;
import hxblit.TextureAtlas.FloatRect;
import hxblit.TextureAtlas.IntRect;
import hxblit.Camera;
import refraction.core.Component;
import refraction.generic.Position;

/**
 * ...
 * @author worldedit
 */

class Surface2RenderComponentC extends Component
{

	public var frameTime:Int;
	private var time:Int;
	public var frame:Int;
	public var animations:Array<Array<Int>>;
	private var coordX:Int;
	private var coordY:Int;
	private var surface2Set:Surface2SetComponent;
	private var position:Position;
	public var numRot:Int;
	public var curAnimaition:Int;
	public var camera:Camera;
	
	private var surfaceName:String;
	
	public function new(_camera:Camera = null, _surfaceName:String = null) 
	{
		super();
		surfaceName = _surfaceName;
		camera = _camera;
		numRot = 32;

		coordX = coordY = 0;
		animations = new Array<Array<Int>>();
		animations.push([0,0, 0,1, 2,1]);
		frameTime = 4;
		curAnimaition = 0;
		frame = 0;
	}
	
	override public function load():Void 
	{
		surface2Set = entity.getComponent(Surface2SetComponent, surfaceName);
		position = entity.getComponent(Position);
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
		if (position.rotation < 0)
		{
			position.rotation += 360;
		}else if (position.rotation >= 360)
		{
			position.rotation -= 360;
		}
		var offsetX = 0.0;
		var offsetY = 0.0;

		coordX = Math.round(position.rotation / 360 * numRot) % numRot;

		if(surface2Set.registrationX != 0 || surface2Set.registrationY != 0){
			var a = coordX/numRot * 2 * 3.1415;
			var cs = Math.cos(a);
			var sn = Math.sin(a);
			offsetX = surface2Set.registrationX * cs - surface2Set.registrationY * sn;
			offsetY = surface2Set.registrationX * sn + surface2Set.registrationY * cs;
		}

		KhaBlit.blit(surface2Set.surfaces[cast coordX + coordY * numRot],
					cast (Math.round(position.x - surface2Set.translateX) - camera.X() - offsetX),
					cast (Math.round(position.y - surface2Set.translateY) - camera.Y() - offsetY));
	}
	
}