package ;
import flash.Lib;
import flash.text.TextField;
import flash.text.TextFormat;

/**
 * ...
 * @author ...
 */
class TextPrompt
{
	static private var textField:TextField;
	public static var decay:Bool;
	
	public static function init():Void
	{
		textField = new TextField();
		Lib.current.stage.addChild(textField);
		textField.x = textField.y = 100;
		textField.mouseEnabled = false;
		textField.width = 600;
		textField.text = " ";
		decay = true;
		textField.defaultTextFormat = (new TextFormat("verdana", 20, 0xffffff, true));
	}
	
	public static function display(_msg:String):Void
	{
		textField.alpha = 1;
		textField.text = _msg;
		textField.setTextFormat(new TextFormat("verdana", 20, 0xffffff, true));
	}
	
	public static function update() 
	{
		if(decay)
		textField.alpha *= 0.98;
	}
	
	public static function hide():Void
	{
		textField.visible = false;
	}
	
	public static function show():Void
	{
		textField.visible = true;
	}
	
	public static function clear():Void
	{
		textField.text = '';
	}
	
	public function new() 
	{
		
	}
	
}