package refraction.control;

import kha.math.FastVector2;
import refraction.core.Component;
import refraction.generic.Position;
import refraction.generic.Velocity;

/**
 * ...
 * @author 
 */
class BreadCrumbsComponent extends Component
{
	
	public var breadcrumbs:Array<FastVector2>;
	public var acceptanceRadius:Float;
	public var maxAcceleration:Float;
	
	public var position:Position;
	public var velocity:Velocity;

	public function new() 
	{
		breadcrumbs = new Array();
		
		super();
	}

	override private function setupField(_name:String, _value:Dynamic):Void {
		if(_name == "acceptanceRadius"){
			acceptanceRadius = _value;
		}else if(_name == "maxAcceleration"){
			maxAcceleration = _value;
		}
	}
	
	public function addBreadCrumb(_v:FastVector2){
		breadcrumbs.push(_v);
	}
	
	override public function load():Void 
	{
		position = entity.getComponent(Position);
		velocity = entity.getComponent(Velocity);
	}
	
}