package refraction.systems;

import refraction.core.SubSystem;
import zui.Zui;
import zui.Id;
import refraction.core.Application;
import refraction.generic.TooltipComponent;
import kha.math.Vector2;

/**
 * ...
 * @author 
 */
class TooltipSystem
{
	private var ui:Zui;
	private var tooltips:Array<TooltipComponent>;

	public function new(_ui:Zui) 
	{
		ui = _ui;
		tooltips = new Array<TooltipComponent>();
	}

	public function addComponent(_tooltip:TooltipComponent):Void
	{
		tooltips.push(_tooltip);
	}
	
	public function update(g2:kha.graphics2.Graphics)
	{
		var mouseCoords = new Vector2(Application.mouseX / 2, Application.mouseY / 2);

		var hoveredItems = tooltips.filter(function(tooltip) return tooltip.containsPoint(mouseCoords));
		if(hoveredItems.length != 0){
			var bestOne = hoveredItems[0];
			g2.begin(false);
			g2.color = kha.Color.Black;
			g2.fillRect(Application.mouseX, Application.mouseY, kha.Assets.fonts.OpenSans.width(16,bestOne.message) + 20,
				kha.Assets.fonts.OpenSans.height(16) + 10);
			g2.font = kha.Assets.fonts.OpenSans;
			g2.fontSize = 16;
			g2.color = kha.Color.White;
			g2.drawString(bestOne.message, Application.mouseX +10, Application.mouseY + 5);
			g2.end();
			//var tooltipWidth:Float = Assets.fonts.OpenSans.width(ui.g.font)
			//if (ui.window(Id.handle(), Application.mouseX, Application.mouseY, 100, 100, false)) {
			//	ui.text(bestOne.message, zui.Align.Left);
				
			//}
			
		}
	}
	
}