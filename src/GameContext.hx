package;
import hxblit.TextureAtlas.IntRect;
import kha.Assets;
import kha.graphics2.Graphics;
import refraction.control.DampingComponent;
import refraction.core.ActiveComponent;
import refraction.core.Entity;
import refraction.core.SubSystem;
import refraction.display.Canvas;
import refraction.display.Surface2RenderComponentC;
import refraction.ds2d.DS2D;
import refraction.generic.VelocityComponent;
import refraction.systems.BreadCrumbsSystem;
import refraction.systems.LightSourceSystem;
import refraction.systems.SpacingSystem;
import refraction.tile.Surface2TileRenderComponent;
import refraction.tile.TileCollisionComponent;
import refraction.tile.TilemapDataComponent;

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
	public var controlSystem:SubSystem<ActiveComponent>;
	public var velocitySystem:SubSystem<VelocityComponent>;
	public var dampingSystem:SubSystem<DampingComponent>;
	public var collisionSystem:SubSystem<TileCollisionComponent>;
	public var npcSystem:SubSystem<NPCComponent>;
	public var breadCrumbsSystem:BreadCrumbsSystem;
	public var aiSystem:SubSystem<ActiveComponent>;
	public var lightSourceSystem:LightSourceSystem;
	
	public var spacingSystem:SpacingSystem;
	public var lightingSystem:DS2D;
	
	public var worldMouseX:Int;
	public var worldMouseY:Int;
	
	public function new(_cameraRect:IntRect) 
	{
		cameraRect = _cameraRect;
		currentMap = null;
		
		statusText = new StatusText();
		
		worldMouseX = worldMouseY = 0;
		
		surface2RenderSystem = new SubSystem<Surface2RenderComponentC>();
		controlSystem = new SubSystem<ActiveComponent>();
		velocitySystem = new SubSystem<VelocityComponent>();
		dampingSystem = new SubSystem<DampingComponent>();
		collisionSystem = new SubSystem<TileCollisionComponent>();
		npcSystem = new SubSystem<NPCComponent>();
		breadCrumbsSystem = new BreadCrumbsSystem();
		aiSystem = new SubSystem<ActiveComponent>();
		lightSourceSystem = new LightSourceSystem();
		spacingSystem = new SpacingSystem();
		
		lightingSystem = new DS2D();
		
	}
	
}