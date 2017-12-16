package entbuilders;
import refraction.core.Entity;
import refraction.generic.PositionComponent;
import refraction.generic.TransformComponent;
import refraction.generic.DimensionsComponent;
import refraction.display.Surface2RenderComponentC;
import refraction.generic.TooltipComponent;
import components.InteractComponent;

/**
 * ...
 * @author 
 */
 
class ItemBuilder
{

	private var gameContext:GameContext;

	public function create(_x = 0, _y = 0, _itemId:Int):Entity
	{
		var e:Entity = new Entity();
		e.addComponent(new PositionComponent(_x, _y));
		e.addComponent(new DimensionsComponent(32,32));
		e.addComponent(new TransformComponent());
		e.addComponent(ResourceFormat.getSurfaceSet("items"));
		
		var surfaceRender:Surface2RenderComponentC = new Surface2RenderComponentC();
		e.addComponent(surfaceRender);
		surfaceRender.camera = gameContext.cameraRect;

		surfaceRender.animations[0] = [0];
		surfaceRender.animations.push([1]);
		surfaceRender.animations.push([2]);
		surfaceRender.animations.push([3]);
		surfaceRender.curAnimaition = 0;
		surfaceRender.frame = 0;
		
		gameContext.surface2RenderSystem.addComponent(surfaceRender);

		var tt:TooltipComponent = new TooltipComponent(gameContext.cameraRect, "Demon Hunter's Crossbow", kha.Color.Green);
		e.addComponent(tt);
		gameContext.tooltipSystem.addComponent(tt);

		var ic = new InteractComponent(gameContext.cameraRect, function(e:Entity){
			trace(_itemId);
			e.remove();
		});
		gameContext.interactSystem.addComponent(ic);
		e.addComponent(ic);

		return e;
	}

	public function new(_gameContext:GameContext)
	{
		gameContext = _gameContext;
	}
	
}