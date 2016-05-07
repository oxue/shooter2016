package refraction.core;
import flash.display.Stage;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.Lib;

/**
 * ...
 * @author worldedit
 */

class Application 
{
	public static var stage:Stage;
	public static var currentState:State;
	public static var mouseIsDown:Bool;
	
	public static var mouseX:Int;
	public static var mouseY:Int;
	
	public static var keys:IntHash<Bool>;
	
	public static function init():Void
	{
		stage = Lib.current.stage;
		currentState = new State();
		keys = new IntHash<Bool>();
		stage.addEventListener(Event.ENTER_FRAME, update);
		stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
		stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
		stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
		stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
	}
	
	static private function mouseMove(e:MouseEvent):Void 
	{
		mouseX = cast stage.mouseX;
		mouseY = cast stage.mouseY;
	}
	
	static private function mouseDown(e:MouseEvent):Void 
	{
		mouseIsDown = true;
	}
	
	static private function mouseUp(e:MouseEvent):Void 
	{
		mouseIsDown = false;
	}
	
	static private function keyDown(e:KeyboardEvent):Void 
	{
		keys.set(e.keyCode, true);
	}
	
	static private function keyUp(e:KeyboardEvent):Void 
	{
		keys.set(e.keyCode, false);
	}
	
	public static function setState(_state:State):Void
	{
		currentState.unload();
		currentState = _state;
		_state.load();
	}
	
	static private function update(e:Event):Void 
	{
		currentState.update();
		currentState.render();
	}
	
}