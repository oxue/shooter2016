package;
import hxblit.TextureAtlas.IntRect;
import kha.Assets;
import kha.graphics2.Graphics;
import refraction.control.DampingComponent;
import refraction.core.Component;
import refraction.core.Entity;
import refraction.core.SubSystem;
import refraction.display.Canvas;
import refraction.display.Surface2RenderComponentC;
import refraction.ds2d.DS2D;
import refraction.generic.VelocityComponent;
import refraction.systems.BreadCrumbsSystem;
import refraction.systems.LightSourceSystem;
import refraction.systems.SpacingSystem;
import refraction.systems.TooltipSystem;
import refraction.tile.Surface2TileRenderComponent;
import refraction.tile.TileCollisionComponent;
import refraction.tile.TilemapDataComponent;
import zui.Zui;
import components.InteractComponent;
import systems.InteractSystem;

/**
 * ...
 * @author 
 */

class GameContext
{

	public var cameraRect:IntRect;
	public var currentMap:Surface2TileRenderComponent;
	public var currentTilemapData:TilemapDataComponent;
	
	public var playerEntity:Entity;
	
	public var statusText:StatusText;
	
	public var surface2RenderSystem:SubSystem<Surface2RenderComponentC>;
	public var controlSystem:SubSystem<Component>;
	public var velocitySystem:SubSystem<VelocityComponent>;
	public var dampingSystem:SubSystem<DampingComponent>;
	public var collisionSystem:SubSystem<TileCollisionComponent>;
	public var interactSystem:InteractSystem;
	public var breadCrumbsSystem:BreadCrumbsSystem;
	public var aiSystem:SubSystem<Component>;
	public var lightSourceSystem:LightSourceSystem;
	
	public var spacingSystem:SpacingSystem;
	public var lightingSystem:DS2D;
	public var tooltipSystem:TooltipSystem;
	
	public var worldMouseX:Int;
	public var worldMouseY:Int;

	public var ui:Zui;
	
	public function new(_cameraRect:IntRect, _ui:Zui) 
	{
		cameraRect = _cameraRect;
		currentMap = null;
		ui = _ui;
		
		statusText = new StatusText();
		
		worldMouseX = worldMouseY = 0;
		
		surface2RenderSystem = new SubSystem<Surface2RenderComponentC>();
		controlSystem = new SubSystem<Component>();
		velocitySystem = new SubSystem<VelocityComponent>();
		dampingSystem = new SubSystem<DampingComponent>();
		collisionSystem = new SubSystem<TileCollisionComponent>();
		interactSystem = new InteractSystem();
		breadCrumbsSystem = new BreadCrumbsSystem();
		aiSystem = new SubSystem<Component>();
		lightSourceSystem = new LightSourceSystem();
		spacingSystem = new SpacingSystem();
		
		lightingSystem = new DS2D();
		tooltipSystem = new TooltipSystem(ui);
	}
	
}