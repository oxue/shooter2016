package refraction.control;

import kha.math.FastVector2;
import refraction.core.ActiveComponent;
import refraction.generic.PositionComponent;
import refraction.generic.TransformComponent;
import refraction.generic.VelocityComponent;

/**
 * ...
 * @author 
 */
class BreadCrumbsComponent extends ActiveComponent
{
	
	public var breadcrumbs:Array<FastVector2>;
	public var acceptanceRadius:Float;
	public var maxAcceleration:Float;
	
	public var position:PositionComponent;
	public var velocity:VelocityComponent;
	public var rotation:TransformComponent;

	public function new(_acceptanceRadius:Float, _maxAcceleration:Float) 
	{
		acceptanceRadius = _acceptanceRadius;
		maxAcceleration = _maxAcceleration;
		breadcrumbs = new Array();
		
		super("BreadCrumbsComponent");
	}
	
	public function addBreadCrumb(_v:FastVector2){
		breadcrumbs.push(_v);
	}
	
	override public function load():Void 
	{
		position = cast entity.components.get("pos_comp");
		rotation = cast entity.components.get("trans_comp");
		velocity = cast entity.components.get("vel_comp");
	}
	
}