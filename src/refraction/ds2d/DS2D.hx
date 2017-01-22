package refraction.ds2d;


import haxe.ds.Vector;
import hxblit.DecrementPipeline;
import hxblit.KhaBlit;
import hxblit.ShadowPipelineState;
import kha.Color;
import kha.graphics4.Graphics;
import kha.math.FastMatrix4;

import hxblit.LightPipelineState;
import hxblit.TextureAtlas.FloatRect;
import kha.graphics4.DepthStencilFormat;
import kha.Image;
import kha.math.FastMatrix3;
import kha.math.FastVector2;
import kha.math.FastVector3;

import refraction.core.Application;

/**
 * ...
 * @author werber
 */
class DS2D 
{
	public var lights:Array<LightSource>;
	public var polygons:Array<Polygon>;
	public var circles:Array<Circle>;
	
	/*public var s:Sprite;*/
	
	public var shadowBuffer:Image;
	public var offBuffer:Image;
	public var lshader:LightPipelineState;
	public var sshader:ShadowPipelineState;// ShadowShader;
	public var decShader:DecrementPipeline;
	
	private var tempV3:FastVector2;
	private var tempV32:FastVector3;
	private var tempP:FastVector2;
	private var drawRect:FloatRect;
	
	private var ambientLevel:Float;
	private var ambientColor:Color;
	var experimentalCullingEnabled = false;
	
	public function new() 
	{
		tempV3 = new FastVector2();
		tempV32 = new FastVector3();
		tempP = new FastVector2();
		lights = new Array<LightSource>();
		polygons = new Array<Polygon>();
		circles = new Array<Circle>();
		#if nodejs
		shadowBuffer = Image.createRenderTarget(400, 200, null, true);
		offBuffer = Image.createRenderTarget(400, 200, null, true);
		#else
		shadowBuffer = Image.createRenderTarget(400, 200, null, DepthStencilFormat.Depth24Stencil8);
		offBuffer = Image.createRenderTarget(400, 200, null, DepthStencilFormat.Depth24Stencil8);
		#end
		lshader = new LightPipelineState();
		sshader = new ShadowPipelineState();
		drawRect = new FloatRect(0, 0, 400, 200);
		decShader = new DecrementPipeline();
		//circles.push(new Circle(100, 100, 5));
		ambientColor = Color.fromValue(0xffffff);
		ambientLevel = 0.7;
	}
	
	public function setAmbientLevel(_level:Float){ ambientLevel = Math.max(Math.min(1, _level), 0); }
	public function getAmbientLevel():Float { return ambientLevel; }
	public function addLightSource(_l:LightSource) { lights.push(_l); }
	
	public function renderHXB(gameContext:GameContext)
	{	
		shadowBuffer.g4.begin();
		
		var backbuffer:Graphics = KhaBlit.contextG4;
		
		KhaBlit.setContext(shadowBuffer.g4);
		KhaBlit.clear(
			ambientLevel * ambientColor.R,
			ambientLevel * ambientColor.G, 
			ambientLevel * ambientColor.B, 1, 1, 1);//ambientLevel * ambientColor.B, 1, 1, 1);
			
		KhaBlit.setPipeline(decShader);
		KhaBlit.setUniformMatrix4("mproj", KhaBlit.matrix2);
		KhaBlit.setUniformTexture("tex", ResourceFormat.atlases.get("all").image);
		gameContext.currentMap.threashold = true;
		gameContext.currentMap.mode = 1;
		gameContext.currentMap.update();
		
		KhaBlit.draw();

		var i:Int = lights.length;
		var rv:Int = 0;
		while (i-->0){
			var l:LightSource = lights[i];
			
			var camPos:FastVector2 = new FastVector2(gameContext.cameraRect.x, gameContext.cameraRect.y);
			
			var lx = l.position.x;
			var ly = l.position.y;
			
			//l.radius = 300;
			//--
			sshader.stencilReferenceValue = rv + 1;
			KhaBlit.setPipeline(sshader);
			KhaBlit.setUniformMatrix4("mproj", KhaBlit.matrix2);
			KhaBlit.setUniformVec2("cpos", l.position.sub(camPos));
			
			var j:Int = polygons.length;
			while (j-->0)
			{
				var p:Polygon = polygons[j];
				if ((p.x - lx) * (p.x - lx) + (p.y - ly) * (p.y - ly) > l.radius * l.radius)
				continue;
				var k:Int = p.faces.length;
				while (k-->0)
				{
					var f:Face = p.faces[k];
					if(experimentalCullingEnabled){
						if (f.cullNature == 1)
						{
							//trace("CULL 1");
							if (lx > f.v1._0)
							continue;
						}else if (f.cullNature == 2)
						{
							//trace("CULL 2");
							if (lx  <f.v1._0)
							continue;
						}else if (f.cullNature == 3)
						{
							if (ly > f.v1._1)
							continue;
						}else if (f.cullNature == 4)
						{
							if (ly < f.v1._1)
							continue;
						}
					}
					//trace(f.v1._0, f.v1._1, f.v2._0, f.v2._1);
					KhaBlit.pushQuad3(f.v2._0 - camPos.x,
									 f.v2._1 - camPos.y, 0,
									 f.v1._0 - camPos.x,  
									 f.v1._1 - camPos.y, 0,
									                
									 f.v1._0 - camPos.x,  
									 f.v1._1 - camPos.y, 1,
									 f.v2._0 - camPos.x,  
									 f.v2._1 - camPos.y, 1);
				}
			}
			
			KhaBlit.draw();
			
			
			lshader.stencilReferenceValue = rv + 2;
			KhaBlit.setPipeline(lshader);
			KhaBlit.setUniformMatrix4("mproj", KhaBlit.matrix2);
			KhaBlit.setUniformVec2("cpos", l.position.sub(camPos));
			KhaBlit.setUniformFloat("radius", l.radius);
			KhaBlit.setUniformVec4("color", l.v3Color);
			//drawRect.x = drawRect.y = 30;
			KhaBlit.pushRect(drawRect);
			KhaBlit.draw();
			rv++;
		}
		shadowBuffer.g4.end();
		
		backbuffer.begin();
		KhaBlit.setContext(backbuffer);
		KhaBlit.KHBTex2PipelineState.blendMultiply();
		KhaBlit.setPipeline(KhaBlit.KHBTex2PipelineState);
		KhaBlit.matrix2 = FastMatrix4.scale(1, -1, 1).multmat(KhaBlit.matrix2);

		KhaBlit.setUniformMatrix4("mproj", KhaBlit.matrix2);
		KhaBlit.setUniformTexture("tex", shadowBuffer);
		KhaBlit.blit(KhaBlit.getSurface(400, 200), -1, 1);
		KhaBlit.draw();
		KhaBlit.matrix2 = FastMatrix4.scale(1, -1,1).multmat(KhaBlit.matrix2);

		backbuffer.end();
		
		gameContext.currentMap.threashold = false;
		KhaBlit.KHBTex2PipelineState.blendAlpha();
		
		
		
		//remove this later
		/*var cx:Float = cast(Application.currentState, GameState).canvas.camera.x;
		var cy:Float = cast(Application.currentState, GameState).canvas.camera.y;
		var cr:Float = cast(Application.currentState, GameState).canvas.camera.width + cx;
		var cb:Float = cast(Application.currentState, GameState).canvas.camera.height + cy;*/
		/*lights[0].x = cast (cast(Application.currentState,GameState).player.components.get("pos_comp")).x + 10;
		lights[0].y = cast (cast(Application.currentState, GameState).player.components.get("pos_comp")).y + 10;
		*/
		/*HxBlit.context.setRenderToTexture(shadowBuffer,true);
		
		//decrement solid tiles
		HxBlit.clear(.05, .05, .05, 1, 1, 1);
		//HxBlit.clear(0, 0, 0, 1, 1, 1);
		HxBlit.context.setStencilActions(Context3DTriangleFace.FRONT_AND_BACK,
										 Context3DCompareMode.ALWAYS,
										 Context3DStencilAction.DECREMENT_SATURATE);
		HxBlit.setBlendMode("NOTHING");
		HxBlit.HXB_shader2.mproj = HxBlit.matrix2;
		HxBlit.HXB_shader2.tex = HxBlit.atlas.texture;
		cast(Application.currentState, GameState).s2tilemaprender.threashold = true;
		cast(Application.currentState, GameState).s2tilemaprender.mode = 1;
		cast(Application.currentState, GameState).s2tilemaprender.update();
		HxBlit.draw();
		cast(Application.currentState, GameState).s2tilemaprender.threashold = false;*/
		
		//--
		
		/*var i:Int = lights.length;
		var rv:Int = 0;
		while (i-->0)
		{
			var l:LightSource = lights[i];
			if (l.x < cx - l.radius/2)
			if (l.y < cy - l.radius/2)
			if (l.x < cr + l.radius/2)
			if (l.y < cb + l.radius/2)
			continue;
			
			HxBlit.setShader(sshader, 3);
			tempV3.x = l.x - cx;
			tempV3.y = l.y - cy;
			tempV3.z = l.y - cy;
			tempV3.w = l.y - cy;
			cast(HxBlit.currentShader, ShadowShader).mproj = HxBlit.matrix2;
			cast(HxBlit.currentShader, ShadowShader).cpos = tempV3;
			
			//increment shadow
			//{
			HxBlit.setBlendMode("ADD");
			HxBlit.context.setStencilReferenceValue(rv + 1);
			HxBlit.context.setStencilActions(Context3DTriangleFace.FRONT_AND_BACK, 	
											 Context3DCompareMode.EQUAL, 
											 Context3DStencilAction.INCREMENT_SATURATE);
			var j:Int = polygons.length;
			while (j-->0)
			{
				var p:Polygon = polygons[j];
				if ((p.x - l.x) * (p.x - l.x) + (p.y - l.y) * (p.y - l.y) > l.radius * l.radius)
				continue;
				var k:Int = p.faces.length;
				while (k-->0)
				{
					var f:Face = p.faces[k];
					if (f.cullNature == 1)
					{
						if (l.x < f.v1._0)
						continue;
					}else if (f.cullNature == 2)
					{
						if (l.x  >f.v1._0)
						continue;
					}else if (f.cullNature == 3)
					{
						if (l.y < f.v1._1)
						continue;
					}else if (f.cullNature == 4)
					{
						if (l.y > f.v1._1)
						continue;
					}
					HxBlit.pushQuad3(f.v2._0 - cx,
									 f.v2._1 - cy, 0,
									 f.v1._0 - cx,  
									 f.v1._1 - cy, 0,
									                
									 f.v1._0 - cx,  
									 f.v1._1 - cy, 1,
									 f.v2._0 - cx,  
									 f.v2._1 - cy, 1);
							
				}	
			}
			
			j = circles.length;
			while (j-->0)
			{
				var c:Circle = circles[j];
				c.x = c.position.x+10;
				c.y = c.position.y+10;
				if ((c.x - l.x) * (c.x - l.x) + (c.y - l.y) * (c.y - l.y) > l.radius * l.radius)
				continue;
				tempP.x = l.x - c.x;
				tempP.y = l.y - c.y;
				tempP.normalize(c.radius);
				HxBlit.pushQuad3(c.x + tempP.y - cx,
								 c.y - tempP.x - cy, 0,
								 c.x - tempP.y - cx,
								 c.y + tempP.x - cy, 0,
								 c.x - tempP.y - cx,
								 c.y + tempP.x - cy, 1,
								 c.x + tempP.y - cx,
								 c.y - tempP.x - cy, 1);
			}
			
			HxBlit.context.setTextureAt(0,null);

			HxBlit.draw();
			//}
			
			HxBlit.context.setStencilReferenceValue(rv + 2);
			HxBlit.context.setStencilActions(Context3DTriangleFace.FRONT_AND_BACK, 
											 Context3DCompareMode.NOT_EQUAL, 
											 Context3DStencilAction.INCREMENT_SATURATE);
											 
			HxBlit.setBlendMode("ADD");
			HxBlit.setShader(lshader, 2);
			tempV3.x = l.x - cx;
			tempV3.y = l.y - cy;
			tempV3.z = 0;
			tempV3.w = 0;
			tempV32.x = l.radius;
			tempV32.z = tempV32.y = tempV32.w;
			cast(HxBlit.currentShader, LightShader).mproj = HxBlit.matrix2;
			cast(HxBlit.currentShader, LightShader).cpos = tempV3;
			cast(HxBlit.currentShader, LightShader).radius = tempV32;
			cast(HxBlit.currentShader, LightShader).color = l.v3Color;
			
			HxBlit.pushRect(drawRect);
			HxBlit.draw();
			if (l.remove == true)
			{
				lights[i] = lights[lights.length - 1];
				lights.length --;
			}
			rv ++;
		}
		
		HxBlit.context.setStencilReferenceValue(0);
		HxBlit.context.setStencilActions(Context3DTriangleFace.FRONT_AND_BACK, 
											 Context3DCompareMode.ALWAYS, 
											 Context3DStencilAction.KEEP);
		
		HxBlit.context.setRenderToBackBuffer();
		HxBlit.setShader(HxBlit.HXB_shader2, 4);
		HxBlit.context.setStencilActions(Context3DTriangleFace.FRONT_AND_BACK, 
											 Context3DCompareMode.ALWAYS, 
											 Context3DStencilAction.KEEP);
		HxBlit.setBlendMode("MULTIPLY");
		cast(HxBlit.currentShader, Shader2).mproj = HxBlit.matrix2;
		cast(HxBlit.currentShader, Shader2).tex = shadowBuffer;

		HxBlit.blit(HxBlit.getSurface(nbpo2(400), nbpo2(200)),-1,1);
		HxBlit.draw();*/
	}
	
	public function wipeout():Void
	{
		lights = new Array<LightSource>();
		polygons = new Array<Polygon>();
	}
	
}

