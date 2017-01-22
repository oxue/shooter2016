package graphite.io;
import flash.events.Event;
import flash.net.URLLoader;
import flash.net.URLRequest;

/**
 * ...
 * @author worldedit
 */

class BinaryLoader 
{
	
	private var loader:URLLoader;
	private var request:URLRequest;
	private var _callback:Void->Void;
	
	public var data:String;

	public function new() 
	{
		data = new String('');
		loader = new URLLoader();
	}
	
	public function load(_url:String, __callback:Void->Void):Void
	{
		_callback = __callback;
		request = new URLRequest(_url);
		loader.addEventListener(Event.COMPLETE, loadComplete);
		loader.load(request);
	}
	
	private function loadComplete(e:Event):Void 
	{
		data = loader.data;
		_callback();
	}
	
}