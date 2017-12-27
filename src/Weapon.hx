package ;
import refraction.display.Surface2RenderComponentC;
import refraction.generic.PositionComponent;
import kha.math.Vector2;

/**
 * ...
 * @author worldedit
 */

class Weapon 
{
	public var type:Int;
	public var name:String;
	public var ammo:AmmunitionObject;
	public var muzzleOffset:Vector2;
	
	public function new(_type:Int = 0, _name:String = "default"):Void
	{
		type = _type;
		name = _name;
	}
	
	public function castWeapon(_position:PositionComponent):Void
	{
		
	}
	public function persistCast(_positionc:PositionComponent):Void
	{
		
	}
	public function setAnimation(_anim:Surface2RenderComponentC):Void
	{
		
	}
	public function getAmmo(_i:InventoryComponent):Void
	{
		
	}
	public function update():Void
	{
		
	}
}