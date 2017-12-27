package ;
import refraction.core.Component;
import refraction.core.Application;
import refraction.generic.PositionComponent;
import kha.math.Vector2;
import refraction.core.Utils;
import refraction.generic.TransformComponent;

/**
 * ...
 * @author worldedit
 */

class InventoryComponent extends Component
{
	
	private var currentWeapon:Weapon;
	private var position:PositionComponent;
	private var rotation:TransformComponent;

	public function new() 
	{
		super("inventory_comp");
	}
	
	override public function load():Void 
	{
		position = entity.getComponent("pos_comp", PositionComponent);
		rotation = entity.getComponent("trans_comp", TransformComponent);
	}
	
	override public function update():Void 
	{		
	
	}

	public function pickup(_itemId:Int):Void
	{
		currentWeapon = new Weapon();
		currentWeapon.muzzleOffset = new Vector2(24,17);
	}
	
	public function wieldingWeapon():Bool
	{
		return currentWeapon != null;
	}

	public function muzzlePositon():Vector2 {
		return position.vec().add(Utils.rotateVec2(currentWeapon.muzzleOffset, Utils.a2rad(rotation.rotation)));
	}

	public function muzzleDirection():Vector2 {
		return EntFactory.instance().worldMouse().sub(position.vec().add(new Vector2(10,10)));
	}

	public function primary():Void
	{
		EntFactory.instance().createProjectile(muzzlePositon(), muzzleDirection());
	}
}