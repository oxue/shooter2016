package refraction.core;
import kha.Framebuffer;
import kha.Key;
import kha.Scheduler;
import kha.System;
import kha.input.Keyboard;
import kha.input.Mouse;

class Application
{
	public static var width:Int;
	public static var height:Int;
	public static var zoom:Int;
	
	public static var currentState:State;
	
	public static var mouseIsDown:Bool;
	public static var mouse2IsDown:Bool;
	public static var mouseX:Int;
	public static var mouseY:Int;
	
	public static var keys:Map<Int, Bool>;
	
	private static var lastTime:Float;
	
	public static function init(_title:String, _width:Int = 800, _height:Int = 600, _zoom:Int = 2, __callback:Void->Void):Void
	{
		currentState = new State();
		keys = new Map<Int, Bool>();
		
		width = _width;
		height = _height;
		zoom = _zoom;
		
		mouseX = mouseY = 0;
		mouseIsDown = false;
		
		System.init({title: _title, width: _width, height: _height}, function() {
			Mouse.get().notify(mouseDown, mouseUp, mouseMove, null);
			Keyboard.get().notify(keyDown, keyUp);
			
			Scheduler.addTimeTask(update, 0, 1 / 60);
			System.notifyOnRender(render);
			
			lastTime = Scheduler.time();
			
			__callback();
		});
	}
	
	static private function mouseMove(x:Int, y:Int, dX:Int, dY:Int)
	{
		mouseX = x;
		mouseY = y;
	}
	
	static private function mouseDown(button:Int, x:Int, y:Int)
	{
		if (button == 0)
		mouseIsDown = true;
		if (button == 1)
		mouse2IsDown = true;
	}
	
	static private function mouseUp(button:Int, x:Int, y:Int)
	{
		if (button == 0)
		mouseIsDown = false;
		if (button == 1)
		mouse2IsDown = false;
	}
	
	static private function keyDown(key:Key, char:String)
	{
		if (char != null)
		keys.set(char.toUpperCase().charCodeAt(0), true);
	}
	
	static private function keyUp(key:Key, char:String)
	{
		if(char != null)
		keys.set(char.toUpperCase().charCodeAt(0), false);
	}
	
	public static function setState(_state:State)
	{
		currentState.unload();
		currentState = _state;
		_state.load();
	}
	
	private static function update()
	{
		currentState.update();
	}
	
	public static function render(frame:Framebuffer){
		currentState.render(frame);
	}
}
