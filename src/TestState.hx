package ;
import flash.display.BitmapData;
import hxblit.HxBlit;
import hxblit.Surface2;
import refraction.core.State;
import refraction.ds2d.DS2D;
import refraction.ds2d.LightSource;
import refraction.ds2d.Polygon;

/**
 * ...
 * @author qwerber
 */

class TestState extends State
{
	private var p:Bool;
	private var x:Int;
	private var s:Surface2;
	
	public function new() 
	{
		super();
	}
	
	override public function load():Void 
	{
		p = true;
		HxBlit.init(start,HxBlit.nbpo2(800),HxBlit.nbpo2(400),2);
	}
	
	private function start():Void
	{
		p = false;
		var b:BitmapData = new BitmapData(100, 100,true);
		b.perlinNoise(100, 100, 10, 12, false, false);
		HxBlit.atlas.add(b, 0);
		HxBlit.atlas.pack();
		s = HxBlit.atlas.assets.get(0);
	}
	
	override public function update():Void 
	{
		
	}
	
	override public function render():Void 
	{
		if (p) return;
		trace(0);
		HxBlit.clear(0, 0, 0, 0, 1, 1);
		x++;
		HxBlit.blit(s, x, 100);
		HxBlit.setShader(HxBlit.HXB_shader2, 4);
		HxBlit.HXB_shader2.init( { mproj: HxBlit.matrix2 },
								 { tex:HxBlit.atlas.texture } );
		HxBlit.setBlendMode("ALPHA");
		HxBlit.draw();
		HxBlit.flip();
	}
	
}