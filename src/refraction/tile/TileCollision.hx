package refraction.tile;
/*import flash.geom.Rectangle;
import flash.Vector;*/
import hxblit.TextureAtlas.FloatRect;
import refraction.control.KeyControl;
import refraction.core.Component;
import refraction.generic.Dimensions;
import refraction.generic.Position;
import refraction.generic.Velocity;
import hxblit.Camera;

/**
 * ...
 * @author worldedit
 */

class TileCollision extends Component
{

	public var targetTilemap:TilemapData;
	
	public var position:Position;
	public var dimensions:Dimensions;
	public var velocity:Velocity;
	
	public function new() 
	{
		super();
	}

	override private function setupField(_name:String, _value:Dynamic):Void { 
		if(_name == "tilemap"){
			targetTilemap = _value;
		}
	}

	public function drawHitbox(camera:Camera, g2:kha.graphics2.Graphics):Void
	{
		g2.color = kha.Color.Green;
		g2.drawRect(
			(position.x - camera.x + 1) * 2, 
			(position.y - camera.y - 1) * 2, 
			(dimensions.width) * 2, 
			(dimensions.height) * 2,
			1.0);
	}
	
	override public function load():Void 
	{
		position = entity.getComponent(Position);
		dimensions = entity.getComponent(Dimensions);
		velocity = entity.getComponent(Velocity);
	}
	
	
	
}


