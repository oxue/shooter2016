package ;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.Lib;
import haxe.Json;
import hxblit.HxBlit;
import refraction.control.DampingComponent;
import refraction.control.KeyControlComponent;
import refraction.control.RotationControlComponent;
import refraction.control.RotationFollowComponent;
import refraction.control.WayPointFollowComponent;
import refraction.core.Application;
import refraction.core.Entity;
import refraction.display.BitmapComponent;
import refraction.display.BlitComponent;
import refraction.display.BlitComponentB;
import refraction.display.BlitComponentC;
import refraction.display.Surface2SetComponent;
import refraction.ds2d.Circle;
import refraction.ds2d.LightSource;
import refraction.generic.DimensionsComponent;
import refraction.generic.PositionComponent;
import refraction.generic.TimeRemoverComponent;
import refraction.generic.TransformComponent;
import refraction.generic.VelocityComponent;
import refraction.tile.Surface2TileRenderComponent;
import refraction.tile.TileCollisionComponent;
import refraction.tile.TilemapDataComponent;
import refraction.display.Surface2RenderComponentC;

/**
 * ...
 * @author worldedit
 */

class Factory 
{

	private static var MAN:BitmapComponent;
	private static var ZOMBIE:BitmapComponent;
	private static var WEAPONS:BitmapComponent;
	private static var M357G:BitmapComponent;
	private static var HKMR5G:BitmapComponent;
	private static var TILES:Surface2SetComponent;
	private static var SPARKSS2:Surface2SetComponent;
	
	private static var MANS2:Surface2SetComponent;
	private static var ZOMBIES2:Surface2SetComponent;
	private static var WEAPONSS2:Surface2SetComponent;
	private static var SPARK:BitmapComponent;
	
	public static function init() 
	{
		MAN = new BitmapComponent(new Man(0, 0));
		MAN.bake();
		MAN.bakeForAnimation(new Rectangle(0, 0, 20, 20));
		
		ZOMBIE = new BitmapComponent(new Zombie(0, 0));
		ZOMBIE.bake();
		ZOMBIE.bakeForAnimation(new Rectangle(0, 0, 20, 20));
		WEAPONS = new BitmapComponent(new Weapons(0, 0));
		WEAPONS.bakeForAnimation(new Rectangle(0, 0, 36, 20));
		WEAPONS.translateX += 8;
		M357G = new BitmapComponent(new M357G(0, 0));
		HKMR5G = new BitmapComponent(new HKMR5G(0, 0));
		SPARK = new BitmapComponent(new Sparks(0, 0));
		SPARK.bakeForAnimation(new Rectangle(0, 0, 8, 8),4);
		
		//----
		TILES = new Surface2SetComponent();
		TILES.splitNIndex(new Tiles(0, 0), new Rectangle(0, 0, 16, 16));
		MANS2 = new Surface2SetComponent();
		MANS2.splitNIndex(MAN.cache, new Rectangle(0, 0, MAN.diagnol, MAN.diagnol));
		ZOMBIES2 = new Surface2SetComponent();
		ZOMBIES2.splitNIndex(ZOMBIE.cache, new Rectangle(0, 0, ZOMBIE.diagnol, ZOMBIE.diagnol));
		WEAPONSS2 = new Surface2SetComponent();
		WEAPONSS2.splitNIndex(WEAPONS.cache, new Rectangle(0, 0, WEAPONS.diagnol, WEAPONS.diagnol));
		SPARKSS2 = new Surface2SetComponent();
		SPARKSS2.splitNIndex(SPARK.cache, new Rectangle(0, 0, SPARK.diagnol, SPARK.diagnol));
		
		HxBlit.atlas.pack();
		
		TILES.assignTextures();
		MANS2.assignTextures();
		ZOMBIES2.assignTextures();
		WEAPONSS2.assignTextures();
		SPARKSS2.assignTextures();
		//----
		MANS2.translateX = MAN.translateX;
		MANS2.translateY = MAN.translateY;
		ZOMBIES2.translateX = ZOMBIE.translateX;
		ZOMBIES2.translateY = ZOMBIE.translateY;
		WEAPONSS2.translateX = WEAPONS.translateX;
		WEAPONSS2.translateY = WEAPONS.translateY;
		//Lib.current.addChild(new Bitmap(MAN.cache));

	}
	
	public static function createTilemapHXB(_width:Int, _height:Int, _tilesize:Int, _colIndex:Int):Void
	{
		var e:Entity = new Entity();
		var td:TilemapDataComponent = new TilemapDataComponent(_width, _height, _tilesize, _colIndex);
		e.addComponent(td);
		cast(Application.currentState, GameState).tilemapdata = td;
		e.addComponent(TILES);
		var tr:Surface2TileRenderComponent = new Surface2TileRenderComponent();
		tr.targetCamera = cast(Application.currentState, GameState).canvas;
		cast(Application.currentState, GameState).s2tilemaprender = tr;
		e.addComponent(tr);
	}
	
	public static function createBullet(_x:Float = 0, _y:Float = 0, _x1:Float = 0, _y1:Float = 0, _damage:Int = 50):Void
	{
		var e:Entity = new Entity();
		var p:PositionComponent = new PositionComponent(_x1, _y1);
		p.oldX = cast _x;
		p.oldY = cast _y;
		e.addComponent(p);
		
		var pj:LineProjectileComponent = new LineProjectileComponent();
		pj.targetTilemap = cast(Application.currentState, GameState).tilemapdata;
		cast(Application.currentState, GameState).projectileSystem.addComponent(pj);
		e.addComponent(pj);
		var br:BulletRender = new BulletRender();
		br.targetCanvas = cast(Application.currentState, GameState).canvas;
		cast(Application.currentState, GameState).bulletRenderSystem.addComponent(br);
		e.addComponent(br);
		pj.targetSystem = cast(Application.currentState, GameState).enemyCollideSystem;
		pj.damage = _damage;
	}
	
	public static function createLight(_x:Int, _y:Int, _color:Int, _radius:Int):Void
	{
		var l:LightSource = new LightSource(_x, _y, _color, _radius);
		cast(Application.currentState, GameState).shadowSystem.addLightSource(l);
	}
	
	public static function createWarp(_x:Int = 0, _y:Int = 0, _level:String):Void
	{
		var e:Entity = new Entity();
		var p:PositionComponent = new PositionComponent();
		p.x = _x;
		p.y = _y;
		e.addComponent(p);
		
		var wp:WarpComponent = new WarpComponent();
		wp.level = _level;
		wp.target = cast cast(Application.currentState, GameState).player.components.get("pos_comp");
		cast(Application.currentState, GameState).warpSystem.addComponent(wp);
		e.addComponent(wp);
	}
	
	public static function createFireball(_x:Int = 0, _y:Int = 0, _px:Float, _py:Float):Void
	{
		var e:Entity = new Entity();
		var p:PositionComponent = new PositionComponent(_x, _y);
		var v:VelocityComponent = new VelocityComponent();
		var d:DampingComponent = new DampingComponent(0.9);
		var p1:Point = new Point(_px, _py);
		var value = p1.length * 0.0002;
		value = value <= 8?value:8;
		p1.normalize(value + Math.random() * 4);
		var p2:Point = new Point( -_py, _px);
		p2.normalize(Math.random() * 1 - 0.5);
		e.addComponent(new DimensionsComponent(10, 10));
		var t:TileCollisionComponent = new TileCollisionComponent();
		t.targetTilemap = cast(Application.currentState, GameState).tilemapdata;
		
		cast(Application.currentState, GameState).collisionSystem.addComponent(t);
		
		p1 = p1.add(p2);
		v.velX = p1.x;
		v.velY = p1.y;
		var l:LightSource = new LightSource(_x, _y, 0x0000ff, 10);
		var lc:LightControlComponent = new LightControlComponent();
		lc.targetLight = l;
		e.addComponent(p);
		e.addComponent(v);
		e.addComponent(lc);
		e.addComponent(d);
		e.addComponent(t);
		var fb:FireComponent = new FireComponent();
		fb.targetLight = l;
		fb.targetSystem = cast(Application.currentState, GameState).enemyCollideSystem;
		e.addComponent(fb);
		cast(Application.currentState, GameState).fireSystem.addComponent(fb);

		cast(Application.currentState, GameState).velocitySystem.addComponent(v);
		cast(Application.currentState, GameState).shadowSystem.addLightSource(l);
		cast(Application.currentState, GameState).lightControlSystem.addComponent(lc);
		cast(Application.currentState, GameState).dampingSystem.addComponent(d);
	}
	
	public static function createPlayer(_x:Int = 0, _y:Int = 0):Void
	{
		var e:Entity = new Entity();
		var p:PositionComponent = new PositionComponent(_x, _y);
		var t:TransformComponent = new TransformComponent();
		
		e.addComponent(p);
		e.addComponent(new DimensionsComponent(20, 20));
		e.addComponent(t);
		e.addComponent(MANS2);
		
		var bs2r:Surface2RenderComponentC = new Surface2RenderComponentC();
		e.addComponent(bs2r);
		bs2r.targetCamera = cast(Application.currentState, GameState).canvas;
		
		bs2r.animations[0] = [0]; 
		bs2r.animations.push([0, 1, 0, 2]);
		bs2r.frameTime = 5;
		bs2r.frame = 0;
		
		var we:Entity = new Entity();
		we.addComponent(WEAPONSS2);
		we.addComponent(p);
		we.addComponent(t);
		
		var s2rw:Surface2RenderComponentC = new Surface2RenderComponentC();
		we.addComponent(s2rw);
		s2rw.targetCamera = cast(Application.currentState, GameState).canvas;
		s2rw.animations[0] = [0, 1, 0, 2];

		s2rw.animations.push([0]);
		s2rw.animations.push([3]);
		s2rw.animations.push([4]);
		s2rw.animations.push([5]);
		s2rw.frameTime = 5;
		s2rw.frame = 0;
		
		var v:VelocityComponent = new VelocityComponent();
		cast(Application.currentState, GameState).spacingSystem.add(p,v);
		cast(Application.currentState, GameState).velocitySystem.addComponent(v);
		e.addComponent(v);
		var kC:KeyControlComponent = new KeyControlComponent(1);
		cast(Application.currentState, GameState).controlComponent = kC;
		e.addComponent(kC);
		var d:DampingComponent = new DampingComponent(0.7);
		e.addComponent(d);
		cast(Application.currentState, GameState).dampingSystem.addComponent(d);
		e.addComponent(new DimensionsComponent(20, 20));
		var c:TileCollisionComponent = new TileCollisionComponent();
		c.targetTilemap = cast(Application.currentState, GameState).tilemapdata;
		e.addComponent(c);
		cast(Application.currentState, GameState).collisionSystem.addComponent(c);
		var rc:RotationControlComponent = new RotationControlComponent();
		cast(Application.currentState, GameState).rotationComponent = rc;
		e.addComponent(rc);
		cast(Application.currentState, GameState).player = e;
		
		var a:AnimationControlComponent = new AnimationControlComponent();
		e.addComponent(a);
		cast(Application.currentState, GameState).animationControl = a;
		
		var flal:LightSource = new LightSource(0, 0, 0xaaaaaa, 100);
		
		
		var lc:LightControlComponent = new LightControlComponent();
		lc.targetLight = flal;
		e.addComponent(lc);
		lc.displaceX = 10;
		lc.displaceY = 10;
		
		var i:InventoryComponent = new InventoryComponent();
		i.blitc = s2rw;
		e.addComponent(i);
		i.targetSystem = cast(Application.currentState, GameState).itemSystem;
		cast(Application.currentState, GameState).inventory = i;
		var ir:ItemRenderComponent = new ItemRenderComponent();
		ir.targetCanvas = cast(Application.currentState, GameState).canvas;
		cast(Application.currentState, GameState).inventoryRender = ir;
		
		i.targetFlashLight = flal;
		
		e.addComponent(ir);
		
		
		
		
		cast(Application.currentState, GameState).lightControlSystem.addComponent(lc);
		cast(Application.currentState, GameState).shadowSystem.addLightSource(flal);
		cast(Application.currentState, GameState).s2rendersystem.addComponent(bs2r);
		cast(Application.currentState, GameState).s2rendersystem.addComponent(s2rw);
		a.blc2 = s2rw;
		
		e.addEntity(we);
		
		var hc:HealthComponent = new HealthComponent();
		e.addComponent(hc);
		cast(Application.currentState, GameState).healthBar.hc = hc;
		var pcc:PlayerCollideComponent = new PlayerCollideComponent();
		pcc.targetSystem = cast(Application.currentState, GameState).enemyCollideSystem;
		e.addComponent(pcc);
		cast(Application.currentState, GameState).playerCollide = pcc;
	}
	
	public static function createZombie(_x:Int = 0, _y:Int = 0):Void
	{
		var e:Entity = new Entity();
		
		e.addComponent(new DimensionsComponent(20, 20));
		var p:PositionComponent = new PositionComponent(_x,_y);
		
		e.addComponent(p);
		e.addComponent(ZOMBIES2);
		e.addComponent(new TransformComponent());
		var s2r:Surface2RenderComponentC = new Surface2RenderComponentC();
		s2r.targetCamera = cast(Application.currentState, GameState).canvas;
		cast(Application.currentState, GameState).s2rendersystem.addComponent(s2r);
		e.addComponent(s2r);
		var v:VelocityComponent = new VelocityComponent();
		cast(Application.currentState, GameState).velocitySystem.addComponent(v);
		e.addComponent(v);
		var d:DampingComponent = new DampingComponent(0.9);
		e.addComponent(d);
		e.addComponent(new DimensionsComponent(20, 20));
		cast(Application.currentState, GameState).dampingSystem.addComponent(d);
		cast(Application.currentState, GameState).spacingSystem.add(p,v);
		var rf:RotationFollowComponent = new RotationFollowComponent();
		var wpf:WayPointFollowComponent = new WayPointFollowComponent();
		//cast(Application.currentState, GameState).rotfollowSystem.addComponent(rf);
		cast(Application.currentState, GameState).waypointfollowSystem.addComponent(wpf);
		var c:TileCollisionComponent = new TileCollisionComponent();
		c.targetTilemap = cast(Application.currentState, GameState).tilemapdata;
		e.addComponent(c);
		cast(Application.currentState, GameState).collisionSystem.addComponent(c);
		//rf.followPosition = cast cast(Application.currentState, GameState).player.components.get("pos_comp");
		wpf.addWaypoint(cast cast(Application.currentState, GameState).player.components.get("pos_comp"));
		
		e.addComponent(rf);
		e.addComponent(wpf);
		e.addComponent(new HealthComponent());
		var ec:EnemyCollideComponent = new EnemyCollideComponent();
		e.addComponent(ec);
		cast(Application.currentState, GameState).enemyCollideSystem.addComponent(ec);
		
		//var cir:Circle = new Circle(0, 0, 10);
		//e.addComponent(cir);
		//cast(Application.currentState, GameState).shadowSystem.circles.push(cir);
	}
	
	public static function createSpark(_x:Float, _y:Float, _n:Int = 0):Void
	{
		var e:Entity = new Entity();
		_x += cast Math.random() * 6 - 3;
		_y += cast Math.random() * 6 - 3;
		
		var p:PositionComponent = new PositionComponent(_x, _y);
		e.addComponent(p);
		e.addComponent(SPARKSS2);
		var t:TransformComponent = new TransformComponent();
		t.rotation = 90 * _n;// Std.int(Math.random() * 4) * 90;
		e.addComponent(t);
		var s2r:Surface2RenderComponentC = new Surface2RenderComponentC();
		e.addComponent(s2r);
		
		var v:Int = Std.int(Math.random() * 2);
		
		s2r.numRot = 5;
		s2r.frameTime = 2;
		s2r.animations[0] = [0, 1, 2, 3, 4, 5, 6, 7];
		s2r.animations.push([8, 9, 10, 11, 12, 13, 14, 15]);
		s2r.curAnimaition = Std.int(Math.random() * 2);
		s2r.frame = v;
		cast(Application.currentState, GameState).s2rendersystem.addComponent(s2r);
		s2r.targetCamera = cast(Application.currentState, GameState).canvas;
		
		var tr:TimeRemoverComponent = new TimeRemoverComponent(2 * (8-v) - 1);
		e.addComponent(tr);
		cast(Application.currentState, GameState).timeremoverSystem.addComponent(tr);
	}
	
	public static function createItem(_id:String, _x :Int = 0, _y:Int = 0)
	{
		var e:Entity = new Entity();
		var p:PositionComponent = new PositionComponent(_x, _y);
		e.addComponent(p);
		switch(_id)
		{
			case "HKMR5":
				e.addComponent(HKMR5G);
			
			case "M357":
				e.addComponent(M357G);
				
			case "FlameThrower":
				e.addComponent(M357G);
		}
		var bl:BlitComponent = new BlitComponent();
		e.addComponent(bl);
		bl.targetCanvas = cast(Application.currentState, GameState).canvas;
		cast(Application.currentState, GameState).blitSystemA.addComponent(bl);
		var c:Weapon = null;
		switch(_id)
		{
			case "HKMR5":
				c = new HKMR5();
			
			case "M357":
				c = new M357();
				
			case "FlameThrower":
				c = new FlameThrower();
		}
		var i:ItemComponent = new ItemComponent(c);
		e.addComponent(i);
		cast(Application.currentState, GameState).itemSystem.addComponent(i);
	}
	
	public static function createSpawn(_x:Int, _y:Int)
	{
		var e:Entity = new Entity();
		var p:PositionComponent = new PositionComponent(_x, _y);
		e.addComponent(p);
		var sp:Spawner = new Spawner();
		e.addComponent(sp);
		cast(Application.currentState, GameState).spawnSystem.addComponent(sp);
	}
}