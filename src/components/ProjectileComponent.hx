package components;

import kha.math.Vector2;
import refraction.tile.TilemapData;
import refraction.core.Component;
import refraction.generic.Position;

/**
 * ...
 * @author 
 */
class ProjectileComponent extends Component
{
	private var position:Position;
	public var tilemapData:TilemapData;
	
	public function new(_tilemapData:TilemapData) 
	{
		tilemapData = _tilemapData;
		super();
	}
	
	override public function load():Void 
	{
		position = entity.getComponent(Position);
	}

	override public function update():Void
	{
		if(tilemapData.hitTestPoint(new Vector2(position.x + 15, position.y + 15))){
			entity.remove();
		}
	}
	
}