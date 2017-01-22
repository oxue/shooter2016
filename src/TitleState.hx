package ;

import flash.display.Bitmap;
import flash.Lib;
import refraction.core.Application;
import refraction.core.State;

/**
 * ...
 * @author qwerber
 */

 
class TitleState extends State
{
	private var bmp:Bitmap;
	private var changing:Bool;
	
	public function new() 
	{
		bmp = new Bitmap(new SplahG(0, 0));
		Lib.current.stage.addChild(bmp);
		bmp.scaleX = bmp.scaleY = 2;
		
		changing = false;
		super();
	}
	
	override public function update():Void 
	{
		if (Application.mouseIsDown)
		{
			changing = true;
		}
		if (changing)
		{
			bmp.alpha *= 0.9;
		}
		if (bmp.alpha <= 0.05)
		{
			Lib.current.stage.removeChild(bmp);
			Application.setState(new GameState());
		}
	}
	
}