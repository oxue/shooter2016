package refraction.tile;
//import hxblit.HxBlit;
import hxblit.KhaBlit;
import hxblit.Camera;
import refraction.core.Component;
import refraction.display.Canvas;
import refraction.display.Surface2SetComponent;

/**
 * ...
 * @author qwerber
 */

class Surface2TileRenderComponent extends Component
{
	private var surface2set:Surface2SetComponent;
	private var tilemapData:TilemapDataComponent;
	
	public var threashold:Bool;
	public var mode:Int;
	public var targetCamera:Camera;
	
	public function new() 
	{
		super("surface2tilerender_comp");
	}
	
	override public function load():Void 
	{
		surface2set = cast entity.components.get("surface2set_comp");
		tilemapData = cast entity.components.get("tilemapdata_comp");
	}
	
	override public function update():Void 
	{							 
		var left:Int = Math.floor(targetCamera.X() / tilemapData.tilesize);
		left = (left < 0)?0:left;
		var right:Int = Math.ceil((targetCamera.X() + targetCamera.w) / tilemapData.tilesize);
		right = (right > tilemapData.width)?tilemapData.width:right;
		
		var up:Int = Math.floor(targetCamera.Y() / tilemapData.tilesize);
		up = (up < 0)?0:up;
		var down:Int = Math.ceil((targetCamera.Y() + targetCamera.h) / tilemapData.tilesize);
		down = (down > tilemapData.height)?tilemapData.height:down;
		
		var i:Int = down;
		while (i-->up)
		{
			var j:Int = right;
			while (j-->left)
			{
				var index:Int = tilemapData.data[i][j].imageIndex;
				if(threashold)
				{
					if (mode == 0)
					{
						if (index > tilemapData.colIndex)
						{
							continue;
						}
					}else
					{
						if (index <= tilemapData.colIndex)
						{
							continue;
						}
					}
				}
				
				KhaBlit.blit(surface2set.surfaces[index],
							cast j * tilemapData.tilesize - targetCamera.X(),
							cast i * tilemapData.tilesize - targetCamera.Y());
			}
		}
		
		//trace(0);
	}
	
}