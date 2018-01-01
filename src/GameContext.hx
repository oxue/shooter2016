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
import refraction.display.AnimatedRender;
import refraction.ds2d.DS2D;
import refraction.generic.Velocity;
import refraction.systems.BreadCrumbsSys;
import refraction.systems.LightSourceSystem;
import refraction.systems.SpacingSys;
import refraction.systems.TooltipSys;
import refraction.tile.Surface2TileRender;
import refraction.tile.TileCollision;
import refraction.tile.TilemapData;
import zui.Zui;
import components.Interactable;
import systems.InteractSys;
import hxblit.Camera;
import refraction.tile.TileCollisionSys;

/**
 * ...
 * @author 
 */

class GameContext
{
	public var camera:Camera;
	public var currentMap:Surface2TileRender;
	public var tilemapData:TilemapData;
	
	public var playerEntity:Entity;
	
	public var statusText:StatusText;
	
	public var surface2RenderSystem:Sys<AnimatedRender>;
	public var selfLitRenderSystem:Sys<AnimatedRender>;
	public var controlSystem:Sys<Component>;
	public var velocitySystem:Sys<Velocity>;
	public var dampingSystem:Sys<Damping>;
	public var collisionSystem:TileCollisionSys;
	public var interactSystem:InteractSys;
	public var breadCrumbsSystem:BreadCrumbsSys;
	public var aiSystem:Sys<Component>;
	public var lightSourceSystem:LightSourceSystem;
	
	public var spacingSystem:SpacingSys;
	public var lightingSystem:DS2D;
	public var tooltipSystem:TooltipSys;

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
		
		surface2RenderSystem = new Sys<AnimatedRender>();
		selfLitRenderSystem = new Sys<AnimatedRender>();
		controlSystem = new Sys<Component>();
		velocitySystem = new Sys<Velocity>();
		dampingSystem = new Sys<Damping>();
		collisionSystem = new TileCollisionSys();
		interactSystem = new InteractSys();
		breadCrumbsSystem = new BreadCrumbsSys();
		aiSystem = new Sys<Component>();
		lightSourceSystem = new LightSourceSystem();
		spacingSystem = new SpacingSys();
		
		hitCheckSystem = new Sys<Component>();

		lightingSystem = new DS2D();
		tooltipSystem = new TooltipSys(ui);
	}
	
}