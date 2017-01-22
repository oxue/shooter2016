package refraction.tile;
/*import flash.geom.Rectangle;
import flash.Vector;*/
import hxblit.TextureAtlas.FloatRect;
import refraction.control.KeyControlComponent;
import refraction.core.ActiveComponent;
import refraction.generic.DimensionsComponent;
import refraction.generic.PositionComponent;
import refraction.generic.VelocityComponent;

/**
 * ...
 * @author worldedit
 */

class TileCollisionComponent extends ActiveComponent
{

	public var targetTilemap:TilemapDataComponent;
	
	private var position:PositionComponent;
	private var dimensions:DimensionsComponent;
	private var velocity:VelocityComponent;
	
	public function new() 
	{
		super("tile_col_comp");
	}
	
	override public function load():Void 
	{
		position = cast entity.components.get("pos_comp");
		dimensions = cast entity.components.get("dim_comp");
		velocity = cast entity.components.get("vel_comp");
	}
	
	override public function update():Void 
	{
		var p:PositionComponent = position;
		var d:DimensionsComponent = dimensions;
		var lastRect:FloatRect = new FloatRect(position.oldX, position.oldY, dimensions.width, dimensions.height);
		var nowRect:FloatRect = lastRect.clone();
		nowRect.x = p.x;
		nowRect.y = p.y;
		var boundRect:FloatRect = lastRect.union(nowRect);
		var velX:Float = velocity.velX;
		var velY:Float = velocity.velY;
		var t:TilemapDataComponent = targetTilemap;
		var bottom:Int = Math.floor(boundRect.bottom() / targetTilemap.tilesize);
		var top:Int = Math.floor(boundRect.top() / targetTilemap.tilesize);
		var right:Int = Math.floor(boundRect.right() / targetTilemap.tilesize);
		var left:Int = Math.floor(boundRect.left() / targetTilemap.tilesize);
		
		if (bottom > t.height-1)
		bottom = t.height - 1;
		
		if (right > t.width-1)
		right = t.width - 1;
		
		if (top < 0)
		top = 0;
		
		if (left < 0)
		left = 0;
		
		if (top > t.height-1)
		top = t.height - 1;
		
		if (left > t.width-1)
		left = t.width - 1;
		
		if (bottom < 0)
		bottom = 0;
		
		if (right < 0)
		right = 0;
		
		var datas:Array<CollisionData> = new Array<CollisionData>();
		
		var i:Int;
		var k:Int;
		var l:Int;
		
		var j:Int;
		var j0:Int;
		var m:Int;
		var n:Int;
		
		if (velY > 0)
		{
			i = bottom;
			k = top - 1;
			l = -1;
		}else
		{
			i = top;
			k = bottom + 1;
			l = 1;
		}
		
		if (velX > 0)
		{
			j0 = right;
			m = left - 1;
			n = -1;
		}else
		{
			j0 = left;
			m = right + 1;
			n = 1;
		}
		
		while (i!=k)
		{
			var j:Int = j0;
			while (j!=m)
			{
				if (t.data[i][j].solid  == true)
				{
					var cdata:CollisionData = solveRect(j * t.tilesize, i * t.tilesize, t.tilesize, t.tilesize);
					if (cdata.collided)
					{
						datas.push(cdata);
					}
				}
				j += n;
			}
			i += l;
		}
		
		if (datas.length == 0)
		return;
		
		var minTime = 100.;
		var data:CollisionData = null;
		i = datas.length;
		while (i-->0)
		{
			if (minTime > datas[i].time)
			{
				minTime = datas[i].time;
				data = datas[i];
			}
		}
		
		if (data.nature == 0)
		{
			p.x -= velX * (1 - minTime);
			p.oldX = p.x;
			p.oldY = p.y - velY * (1 - minTime);
			velocity.velX = 0;
			
		}
		else
		{
			p.y -= velY * (1 - minTime);
			p.oldY = p.y;
			p.oldX = p.x - velX * (1 - minTime);
			velocity.velY = 0;
			
		}
		
		lastRect = new FloatRect(position.oldX, position.oldY, dimensions.width, dimensions.height);
		nowRect = lastRect.clone();
		nowRect.x = p.x;
		nowRect.y = p.y;
		boundRect = lastRect.union(nowRect);
		velX = p.x - p.oldX;
		velY = p.y - p.oldY;
		bottom = Math.floor(boundRect.bottom() / targetTilemap.tilesize);
		top = Math.floor(boundRect.top() / targetTilemap.tilesize);
		right = Math.floor(boundRect.right() / targetTilemap.tilesize);
		left = Math.floor(boundRect.left() / targetTilemap.tilesize);
		datas = new Array<CollisionData>();
		if (velY > 0)
		{
			i = bottom;
			k = top - 1;
			l = -1;
		}else
		{
			i = top;
			k = bottom + 1;
			l = 1;
		}
		
		if (velX > 0)
		{
			j0 = right;
			m = left - 1;
			n = -1;
		}else
		{
			j0 = left;
			m = right + 1;
			n = 1;
		}
		
		while (i!=k)
		{
			var j:Int = j0;
			while (j!=m)
			{
				
				if (i >= 0 && j >= 0 && i < t.data.length && j < t.data[0].length && t.data[i][j].solid  == true)
				{
					var cdata:CollisionData = solveRect(j * t.tilesize, i * t.tilesize, t.tilesize, t.tilesize);
					if (cdata.collided)
					{
						datas.push(cdata);
					}
				}
				j += n;
			}
			i += l;
		}
		
		if (datas.length == 0)
		return;
		
		minTime = 100.;
		data = null;
		i = datas.length;
		while (i-->0)
		{
			if (minTime > datas[i].time)
			{
				minTime = datas[i].time;
				data = datas[i];
			}
		}
		
		if (data.nature == 0)
		{
			p.x -= velX * (1 - minTime);
			p.oldX = p.x;
			p.oldY = p.y - velY * (1 - minTime);
			velocity.velX = 0;
		}
		else
		{
			p.y -= velY * (1 - minTime);
			p.oldY = p.y;
			p.oldX = p.x - velX * (1 - minTime);
			velocity.velY = 0;
			
		}
		
	}
	
	public function solveRect(_tx:Int, _ty:Int, _tw:Int, _th:Int):CollisionData
	{
		var p:PositionComponent = position;
		var d:DimensionsComponent = dimensions;
		var velX:Float = p.x - p.oldX;
		var velY:Float = p.y - p.oldY;
		var dtxc:Float = 0;
		var dtyc:Float = 0;
		var dtxd:Float = 0;
		var dtyd:Float = 0;
		if (velX < 0)
		{
			dtxc = _tx + _tw - p.oldX;
			dtxd = _tx - p.oldX - d.width;
		}
		else
		{
			dtxc = _tx - p.oldX - d.width;
			dtxd = _tx + _tw - p.oldX;
		}
		if (velY < 0)
		{
			dtyc = _ty + _th - p.oldY;
			dtyd = _ty - p.oldY - d.height;
		}
		else
		{
			dtyc = _ty - p.oldY - d.height;
			dtyd = _ty + _th - p.oldY;
		}
		var timeX:Float = dtxc / velX;
		var timeY:Float = dtyc / velY;
		
		
		var t0:Float = Math.max(timeX, timeY);
		
		var disjointTimeX:Float = (dtxd / velX);
		var disjointTimeY:Float = (dtyd / velY);
		
		var t1:Float = Math.min(disjointTimeX, disjointTimeY);
		
		if ((timeX < 0 && timeY < 0) || (timeX > 1 || timeY > 1))
		{
			return new CollisionData(false);
		}
		
		if (t0 < t1)
		{
			return new CollisionData(true, t0,timeX>=timeY?0:1);
		}
		
		return new CollisionData(false);
	}
	
}


