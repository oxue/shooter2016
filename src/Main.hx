package ;

import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.Lib;
import graphite.GDFParser;
import graphite.GraphiteEngine;
import refraction.core.Application;
import refraction.systems.SpacingSystem;

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
		//stage.addChild(new CustomFPS());
		// entry point
		//begin();
		GraphiteEngine.init(begin);
	}
	
	static private function begin() 
	{
		Application.init();
		Application.setState(new TitleState());	
	}
	
}