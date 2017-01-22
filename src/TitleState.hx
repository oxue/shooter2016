package ;

import kha.Assets;
import kha.Color;
import kha.Framebuffer;
import refraction.core.Application;
import refraction.core.State;

/**
 * ...
 * @author qwerber
 */

 
class TitleState extends State
{
	private var changing:Bool;
	private var alpha:Float;
	
	private var paused:Bool;
	
	public function new() 
	{
		
		super();
	}
	
	override public function load():Void 
	{
		paused = true;
		changing = false;
		alpha = 1;
		
		Assets.loadEverything(start);
	}
	
	private function start() 
	{
		paused = false;
	}
	
	override public function render(frame:Framebuffer) 
	{
		if (paused) return;
		
		frame.g2.begin();
		frame.g2.color = Color.fromFloats(1, 1, 1, alpha);
		frame.g2.drawScaledImage(Assets.images.splah, 0, 0, 800, 400);
		frame.g2.end();
	}
	
	override public function update():Void 
	{
		if (paused) return;
		
		if (Application.mouseIsDown)
		{
			changing = true;
		}
		if (changing)
		{
			alpha *= 0.9;
		}
		if (alpha <= 0.05)
		{
			//Application.setState(new GameState());
		}
	}
	
}