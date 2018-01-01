package;
import hxblit.TextureAtlas.IntRect;
import kha.Assets;
import kha.graphics2.Graphics;
import refraction.control.Damping;
import refraction.core.Component;
import refraction.core.Entity;
import refraction.core.Sys;
import refraction.core.Sys.NullSystem;
import refraction.display.Canvas;
import refraction.display.Surface2RenderComponentC;
import refraction.ds2d.DS2D;
import refraction.generic.Velocity;
import refraction.systems.BreadCrumbsSystem;
import refraction.systems.LightSourceSystem;
import refraction.systems.SpacingSystem;
import refraction.systems.TooltipSystem;
import refraction.tile.Surface2TileRenderComponent;
import refraction.tile.TileCollision;
import refraction.tile.TilemapData;
import zui.Zui;
import components.InteractComponent;
import systems.InteractSystem;
import hxblit.Camera;
import refraction.tile.TileCollisionSys;

/**
 * ...
 * @author 
 */

class GameContext
{
	public var camera:Camera;
	public var currentMap:Surface2TileRenderComponent;
	public var tilemapData:TilemapData;
	
	public var playerEntity:Entity;
	
	public var statusText:StatusText;
	
	public var surface2RenderSystem:Sys<Surface2RenderComponentC>;
	public var selfLitRenderSystem:Sys<Surface2RenderComponentC>;
	public var controlSystem:Sys<Component>;
	public var velocitySystem:Sys<Velocity>;
	public var dampingSystem:Sys<Damping>;
	public var collisionSystem:TileCollisionSys;
	public var interactSystem:InteractSystem;
	public var breadCrumbsSystem:BreadCrumbsSystem;
	public var aiSystem:Sys<Component>;
	public var lightSourceSystem:LightSourceSystem;
	
	public var spacingSystem:SpacingSystem;
	public var lightingSystem:DS2D;
	public var tooltipSystem:TooltipSystem;

	public var hitCheckSystem:Sys<Component>;

	public var nullSystem:NullSystem<Component>;
	
	// TODO: Deprecate these ones.
	public var worldMouseX:Int;
	public var worldMouseY:Int;

	public var ui:Zui;
	
	public function new(_camera:Camera, _ui:Zui) 
	{
		camera = _camera;
		currentMap = null;
		ui = _ui;
		
		statusText = new StatusText();
		
		worldMouseX = worldMouseY = 0;
		
		surface2RenderSystem = new Sys<Surface2RenderComponentC>();
		selfLitRenderSystem = new Sys<Surface2RenderComponentC>();
		controlSystem = new Sys<Component>();
		velocitySystem = new Sys<Velocity>();
		dampingSystem = new Sys<Damping>();
		collisionSystem = new TileCollisionSys();
		interactSystem = new InteractSystem();
		breadCrumbsSystem = new BreadCrumbsSystem();
		aiSystem = new Sys<Component>();
		lightSourceSystem = new LightSourceSystem();
		spacingSystem = new SpacingSystem();
		
		hitCheckSystem = new Sys<Component>();

		lightingSystem = new DS2D();
		tooltipSystem = new TooltipSystem(ui);
	}
	
}