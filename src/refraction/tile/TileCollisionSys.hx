package refraction.tile;

import refraction.core.Sys;
import refraction.generic.Position;
import refraction.generic.Dimensions;
import refraction.generic.Velocity;
import refraction.tile.TilemapData;
import refraction.tile.TileCollision;
import hxblit.TextureAtlas.FloatRect;
import hxblit.TextureAtlas.IntBounds;


class TileCollisionSys extends Sys<TileCollision>
{
	private var tilemapData:TilemapData;

	public function new()
	{
		super();
	}

	public function setTilemap(_tilemapData:TilemapData):Void
	{
		tilemapData = _tilemapData;
	}

	override public function update():Void{
		var i = components.length;
		while(i-->0) {
			var tc = components[i];
			collide(tc);
		}
	}

	private function maxi(a:Int, b:Int):Int
	{
		return (a < b) ? b : a;
	}

	private function mini(a:Int, b:Int):Int
	{
		return (a > b) ? b : a;
	}

	private function clamp(a:Int, low:Int, high:Int):Int
	{
		return maxi(mini(a, high), low);
	}

	private function getCollisionBounds(_bound:FloatRect):IntBounds
	{
		var bottom:Int = Math.floor(_bound.bottom() / tilemapData.tilesize);
		var top:Int = Math.floor(_bound.top() / tilemapData.tilesize);
		var right:Int = Math.floor(_bound.right() / tilemapData.tilesize);
		var left:Int = Math.floor(_bound.left() / tilemapData.tilesize);
		
		top = clamp(top, 0, tilemapData.height-1);
		left = clamp(left, 0, tilemapData.width-1);
		bottom = clamp(bottom, 0, tilemapData.height-1);
		right = clamp(right, 0, tilemapData.width-1);
		
		return new IntBounds(left, right, top, bottom);
	}

	private function sweptRect(tc:TileCollision):FloatRect
	{
		var lastRect = new FloatRect(tc.position.oldX, tc.position.oldY, tc.dimensions.width, tc.dimensions.height);
		var nowRect = new FloatRect(tc.position.x, tc.position.y, tc.dimensions.width, tc.dimensions.height);
		return lastRect.union(nowRect);
	}

	private function minTimeData(_datas:Array<CollisionData>):CollisionData
	{
		return Lambda.fold(_datas, function(d:CollisionData, f:CollisionData){
			return (d.time < f.time ? d : f);
		}, _datas[0]);
	}

	private function pushBack(tc:TileCollision, data:CollisionData):Void
	{
		var xFlag = 1 - data.nature;
		var yFlag = data.nature;
		
		// pushback
		tc.position.x -= tc.velocity.velX * (1 - data.time) * xFlag;
		tc.position.y -= tc.velocity.velY * (1 - data.time) * yFlag;

		// remaining part
		tc.position.oldX = tc.position.x - tc.velocity.velX * (1 - data.time) * yFlag;
		tc.position.oldY = tc.position.y - tc.velocity.velY * (1 - data.time) * xFlag;

		tc.velocity.velX = tc.position.x - tc.position.oldX;
		tc.velocity.velY = tc.position.y - tc.position.oldY;
	}

	private function getCollisionsInBound(tc:TileCollision, bounds:IntBounds):Array<CollisionData>
	{
		var datas = new Array<CollisionData>();
		var i = bounds.t;
		while(i<=bounds.b)
		{
			var j = bounds.l;
			while(j<=bounds.r)
			{
				if(tilemapData.data[i][j].solid)
				{
					var cdata = solveRect(
						tc, 
						j * tilemapData.tilesize, 
						i * tilemapData.tilesize, 
						tilemapData.tilesize, 
						tilemapData.tilesize
					);
					if(cdata.collided)
					{
						datas.push(cdata);
					}
				}
				j++;
			}
			i++;
		}
		return datas;
	}

	public function collideOneAxis(tc:TileCollision):Void
	{
		var datas = getCollisionsInBound(tc, getCollisionBounds(sweptRect(tc)));
		
		if (datas.length > 0)
			pushBack(tc, minTimeData(datas));
	}

	private function collide(tc:TileCollision):Void 
	{
		collideOneAxis(tc);
		collideOneAxis(tc);
	}
	
	public function solveRect(_tc:TileCollision, _tx:Int, _ty:Int, _tw:Int, _th:Int):CollisionData
	{
		var position:Position = _tc.position;
		var dimensions:Dimensions = _tc.dimensions;
		var velX:Float = position.x - position.oldX;
		var velY:Float = position.y - position.oldY;
		var dtxc:Float = 0;
		var dtyc:Float = 0;
		var dtxd:Float = 0;
		var dtyd:Float = 0;
		if (velX < 0)
		{
			dtxc = _tx + _tw - position.oldX;
			dtxd = _tx - position.oldX - dimensions.width;
		}
		else
		{
			dtxc = _tx - position.oldX - dimensions.width;
			dtxd = _tx + _tw - position.oldX;
		}
		if (velY < 0)
		{
			dtyc = _ty + _th - position.oldY;
			dtyd = _ty - position.oldY - dimensions.height;
		}
		else
		{
			dtyc = _ty - position.oldY - dimensions.height;
			dtyd = _ty + _th - position.oldY;
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