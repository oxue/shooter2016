package ;

import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.Lib;
import refraction.core.Application;

/**
 * ...
 * @author worldedit
 */

class Main 
{
	
	static function main() 
	{
		var stage = Lib.current.stage;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;
		// entry point
		
		Application.init();
		Application.setState(new TestState());
	}
	
}