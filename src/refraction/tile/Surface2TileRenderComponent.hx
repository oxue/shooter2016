package refraction.tile;
//import hxblit.HxBlit;
import hxblit.KhaBlit;
import hxblit.TextureAtlas.IntRect;
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
	public var targetCamera:IntRect;
	
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
		var left:Int = Math.floor(targetCamera.x / tilemapData.tilesize);
		left = (left < 0)?0:left;
		var right:Int = Math.ceil((targetCamera.x + targetCamera.w) / tilemapData.tilesize);
		right = (right > tilemapData.width)?tilemapData.width:right;
		
		var up:Int = Math.floor(targetCamera.y / tilemapData.tilesize);
		up = (up < 0)?0:up;
		var down:Int = Math.ceil((targetCamera.y + targetCamera.h) / tilemapData.tilesize);
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
							cast j * tilemapData.tilesize - targetCamera.x,
							cast i * tilemapData.tilesize - targetCamera.y);
			}
		}
		
		//trace(0);
	}
	
}