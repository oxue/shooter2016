package refraction.ds2d;

import flash.display.BitmapData;
import flash.display.BlendMode;
import flash.display.Graphics;
import flash.display.Shape;
import flash.display.Sprite;
import flash.display3D.Context3DClearMask;
import flash.display3D.Context3DCompareMode;
import flash.display3D.Context3DStencilAction;
import flash.display3D.Context3DTriangleFace;
import flash.filters.BitmapFilterQuality;
import flash.filters.GlowFilter;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.Vector;
import flash.Vector;
import hxblit.HxBlit;
import hxblit.ShadowShader;
import hxblit.TextureAtlas;
import hxblit.Shader2;
import refraction.core.Application;
import flash.display3D.textures.Texture;
import flash.display3D.Context3DTextureFormat;
import hxblit.LightShader;
import flash.geom.Vector3D;
import flash.geom.Rectangle;
/**
 * ...
 * @author werber
 */
class DS2D 
{
	public var lights:Vector<LightSource>;
	public var polygons:Vector<Polygon>;
	public var circles:Vector<Circle>;
	
	private var tempMatrix:Matrix;
	public var s:Sprite;
	
	private var lList:Vector<Float2>;
	private var prjList:Vector<Float2>;
	public var shadowBuffer:Texture;
	public var offBuffer:Texture;
	public var lshader:LightShader;
	public var sshader:ShadowShader;
	public var s2:Shader2;
	
	private var tempV3:Vector3D;
	private var tempV32:Vector3D;
	private var tempP:Point;
	private var drawRect:Rectangle;
	
	public function new() 
	{
		tempV3 = new Vector3D();
		tempV32 = new Vector3D();
		tempP = new Point();
		lights = new Vector<LightSource>();
		polygons = new Vector<Polygon>();
		circles = new Vector<Circle>();
		tempMatrix = new Matrix();
		s = new Sprite();
		lList = new Vector<Float2>(32, true);
		prjList = new Vector<Float2>(32, true);
		shadowBuffer = HxBlit.context.createTexture(nbpo2(400), nbpo2(200), Context3DTextureFormat.BGRA, true);
		offBuffer = HxBlit.context.createTexture(nbpo2(400), nbpo2(200), Context3DTextureFormat.BGRA, true);
		lshader = new LightShader();
		sshader = new ShadowShader();
		s2 = new Shader2();
		drawRect = new Rectangle(0,0,nbpo2(400),nbpo2(200));
		//circles.push(new Circle(100, 100, 5));
	}
	
	private function nbpo2(_in:Int):Int
	{
		_in --;
		_in = (_in >> 1) | _in;
		_in = (_in >> 2) | _in;
		_in = (_in >> 4) | _in;
		_in = (_in >> 8) | _in;
		_in = (_in >> 16) | _in;
		_in++;
		
		return _in;
	}
	
	public function addLightSource(_l:LightSource):Void
	{
		lights.push(_l);
	}
	
	public function renderHXB()
	{	
		//remove this later
		var cx:Float = cast(Application.currentState, GameState).canvas.camera.x;
		var cy:Float = cast(Application.currentState, GameState).canvas.camera.y;
		var cr:Float = cast(Application.currentState, GameState).canvas.camera.width + cx;
		var cb:Float = cast(Application.currentState, GameState).canvas.camera.height + cy;
		/*lights[0].x = cast (cast(Application.currentState,GameState).player.components.get("pos_comp")).x + 10;
		lights[0].y = cast (cast(Application.currentState, GameState).player.components.get("pos_comp")).y + 10;
		*/
		HxBlit.context.setRenderToTexture(shadowBuffer,true);
		
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
		cast(Application.currentState, GameState).s2tilemaprender.threashold = false;
		
		//--
		
		var i:Int = lights.length;
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
		HxBlit.draw();
	}

	public function render(_data:BitmapData):Void
	{
		//lights[0].x = cast (cast(Application.currentState,GameState).player.components.get("pos_comp")).x+10;
		//lights[0].y = cast (cast(Application.currentState,GameState).player.components.get("pos_comp")).y+10;
		var i:Int = lights.length;
		var n:Int = 0;
		while (i-->0)
		{
			var l:LightSource = lights[i];
			if (l.x == l.lastX && l.y == l.lastY)
			continue;
			var j:Int = polygons.length; 
			l.clear();
			s.graphics.clear();
			var n:Int = 0;
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
					
					n++;
					var pv:Vector<Float> = new Vector < Float>();
					var cv:Vector<Int> = new Vector<Int>();
					s.graphics.beginFill(0xffffff);
					
					
					var dx:Float = f.v1._0 - l.x;
					var dy:Float = f.v1._1 - l.y;
					var dx2:Float = f.v2._0 - l.x;
					var dy2:Float = f.v2._1 - l.y;
					
					pv.push(dx);
					pv.push(dy);
					cv.push(1);
					
					pv.push(dx*10);
					pv.push(dy*10);
					cv.push(2);
					
					pv.push(dx2*10);
					pv.push(dy2*10);
					cv.push(2);
					
					pv.push(dx2);
					pv.push(dy2);
					cv.push(2);
					
					//{
					//s.graphics.drawPath(cv, pv);
					//s.graphics.moveTo(dx,
					//				  dy);
					//s.graphics.lineTo(dx * 10,
					//				  dy * 10);
					//s.graphics.lineTo(dx2 * 10,
					//				  dy2 * 10);
					//s.graphics.lineTo(dx2,
					//				  dy2);
					//}
				}
				//{
				/*var k:Int = p.vertices.length;
				while (k-->0)
				{
					var lp:Float2 = new Float2
					(
					p.vertices[k]._0 - l.x,
					p.vertices[k]._1 - l.y
					);
					var prjp:Float2 = new Float2
					(
					lp._0 * 10,
					lp._1 * 10
					);
					lList[k] = lp;
					prjList[k] = prjp;
				}
				
				k = -1;
				while (k++ < p.vertices.length - 1)
				{
					s.graphics.beginFill(0xffffff);
					s.graphics.moveTo(lList[k]._0, lList[k]._1);
					s.graphics.lineTo(prjList[k]._0, prjList[k]._1);
					s.graphics.lineTo(prjList[(k+1)%p.vertices.length]._0, prjList[(k+1)%p.vertices.length]._1);
					s.graphics.lineTo(lList[(k + 1) % p.vertices.length]._0, lList[(k + 1) % p.vertices.length]._1);
				}*/
				//}
				tempMatrix.tx = l.radius;
				tempMatrix.ty = l.radius;
				l.cache.draw(s, tempMatrix, null, BlendMode.SUBTRACT);
				
				l.lastX = l.x;
				l.lastY = l.y;
			}
		}
		
		i = lights.length;
		while (i-->0)
		{
			var l:LightSource = lights[i];
			//tempMatrix.tx = l.x - l.radius + cast(Application.currentState, GameState).canvas.camera.x;
			//tempMatrix.ty = l.y - l.radius + cast(Application.currentState, GameState).canvas.camera.y;
			_data.draw(l.cache, tempMatrix, null, BlendMode.ADD);
			
			if (l.remove == true)
			{
				lights[i] = lights[lights.length - 1];
				lights.length --;
			}
		}
			
	}
	
	public function wipeout():Void
	{
		lights = new Vector<LightSource>();
		polygons = new Vector<Polygon>();
	}
	
}

