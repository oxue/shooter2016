package ;
import refraction.core.Component;
import refraction.core.Application;
import refraction.generic.Position;
import kha.math.Vector2;
import refraction.core.Utils;

/**
 * ...
 * @author worldedit
 */

class Inventory extends Component
{
	
	private var currentWeapon:Weapon;
	private var position:Position;

	public function new() 
	{
		super();
	}
	
	override public function load():Void 
	{
		position = entity.getComponent(Position);
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
		return position.vec().add(Utils.rotateVec2(currentWeapon.muzzleOffset, Utils.a2rad(position.rotation)));
	}

	public function muzzleDirection():Vector2 {
		return EntFactory.instance().worldMouse().sub(position.vec().add(new Vector2(10,10)));
	}

	public function primary():Void
	{
		EntFactory.instance().createProjectile(muzzlePositon(), muzzleDirection());
	}
}