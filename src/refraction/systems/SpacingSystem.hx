package refraction.systems;
import flash.Vector;
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
	
	public function new(_a:PositionComponent, _b:VelocityComponent)
	{
		p = _a;
		v = _b;
	}
}

 
class SpacingSystem 
{
	
	private var positions:Vector<Pair>;
	
	public function new() 
	{
		positions = new Vector<Pair>();
	}
	
	public function add(_p:PositionComponent, _v:VelocityComponent):Void
	{
		positions.push(new Pair(_p,_v));
	}
	
	public function update():Void
	{
		
		var i:Int = positions.length;
		while (i-->0)
		{
			if (positions[i].p.remove || positions[i].p.removeImmediately)
			{
				positions[i] = positions[positions.length - 1];
				positions.length--;
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
				if ((b2.x - b.x)*(b2.x - b.x)+(b2.y - b.y)*(b2.y - b.y) < 225)
				{
					if (b2.x == b.x && b2.y == b.y)
					{
						cx += Math.random() > 0.5?1:-1;
						cy += Math.random() > 0.5?1:-1;
					}else
					{
					cx = cx - (b2.x - b.x)*1.1;
					cy = cy - (b2.y - b.y)*0.9;
					}
				}
			}
			positions[i].v.velX += cx / 10;
			positions[i].v.velY += cy / 10;
		}
	}
	
}