package entbuilders;
import refraction.core.Entity;
import refraction.generic.Position;
import refraction.generic.Dimensions;
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
		e.addComponent(new Position(_x, _y));
		e.addComponent(new Dimensions(32,32));
		e.addComponent(ResourceFormat.getSurfaceSet("items"));
		
		var surfaceRender:Surface2RenderComponentC = new Surface2RenderComponentC();
		e.addComponent(surfaceRender);
		surfaceRender.camera = gameContext.camera;

		surfaceRender.animations[0] = [0];
		surfaceRender.animations.push([1]);
		surfaceRender.animations.push([2]);
		surfaceRender.animations.push([3]);
		surfaceRender.curAnimaition = 0;
		surfaceRender.frame = 0;
		
		gameContext.surface2RenderSystem.addComponent(surfaceRender);

		var tt:TooltipComponent = new TooltipComponent("Demon Hunter's Crossbow", kha.Color.Green);
		e.addComponent(tt);
		gameContext.tooltipSystem.addComponent(tt);

		var ic = new InteractComponent(gameContext.camera, function(e:Entity){
			trace(_itemId);
			gameContext.playerEntity.getComponent(InventoryComponent).pickup(_itemId);
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