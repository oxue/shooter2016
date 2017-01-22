package refraction.systems;
//import flash.Vector;
import kha.math.FastVector2;
import refraction.generic.PositionComponent;
import refraction.generic.VelocityComponent;

/**
 * ...
 * @author worldedit
 */


class Pair
{
	public var p:PositionComponent;
	public var v:VelocityComponent;
	public var radius:Float;
	
	public function new(_a:PositionComponent, _b:VelocityComponent, _radius:Float)
	{
		p = _a;
		v = _b;
		radius = _radius;
	}
}

 
class SpacingSystem 
{
	
	private var positions:Array<Pair>;
	
	public function new() 
	{
		positions = new Array<Pair>();
	}
	
	public function add(_p:PositionComponent, _v:VelocityComponent, _r:Float):Void
	{
		positions.push(new Pair(_p,_v, _r));
	}
	
	public function update():Void
	{
		
		var i:Int = positions.length;
		while (i-->0)
		{
			if (positions[i].p.remove || positions[i].p.removeImmediately)
			{
				positions[i] = positions[positions.length - 1];
				positions.pop;
				//trace("ARRRGE");
				continue;
			}
			var b:PositionComponent = positions[i].p;
			var j:Int = positions.length;
			var cx:Float = 0;
			var cy:Float = 0;
			while (j-->0)
			{
				var b2:PositionComponent = positions[j].p;
				if (b2 == b)
				continue;
				
				var r2 = Math.pow(positions[i].radius + positions[j].radius,2);
				
				if ((b2.x - b.x)*(b2.x - b.x)+(b2.y - b.y)*(b2.y - b.y) < r2)
				{
					if (b2.x == b.x && b2.y == b.y)
					{
						cx += Math.random() > 0.5?1:-1;
						cy += Math.random() > 0.5?1:-1;
					}else
					{
						var diffVec = new FastVector2(b2.x - b.x, b2.y - b.y);
						var penetrationDepth = positions[i].radius + positions[j].radius - diffVec.length;
						diffVec.normalize();
						var displace = diffVec.mult( -penetrationDepth);
					cx = cx + displace.x; //(b2.x - b.x);
					cy = cy + displace.y;//;- (b2.y - b.y);
					}
				}
			}
			positions[i].v.velX += cx / 8; // 30;
			positions[i].v.velY += cy / 8; //30;
		}
	}
	
}