package components;

import kha.math.Vector2;
import refraction.tile.TilemapDataComponent;
import refraction.core.Component;
import refraction.generic.PositionComponent;

/**
 * ...
 * @author 
 */
class ProjectileComponent extends Component
{
	private var position:PositionComponent;
	private var tilemapData:TilemapDataComponent;
	
	public function new(_tilemapData:TilemapDataComponent) 
	{
		tilemapData = _tilemapData;
		super("projectile_comp");
	}
	
	override public function load():Void 
	{
		position = entity.getComponent("pos_comp", PositionComponent);
	}

	override public function update():Void
	{
		if(tilemapData.hitTestPoint(new Vector2(position.x + 15, position.y + 15))){
			entity.remove();
		}
	}
	
}