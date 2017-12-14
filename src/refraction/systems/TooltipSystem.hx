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
	private var margin:Int = 5;
	private var textSize:Int = 16;

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
			drawTooltip(hoveredItems[0], g2);
		}
	}

	private function drawTooltip(tooltip:TooltipComponent, g2:kha.graphics2.Graphics):Void
	{
		g2.color = kha.Color.Black;
		var textWidth = kha.Assets.fonts.OpenSans.width(textSize,tooltip.message);
		g2.fillRect(
			Application.mouseX,
			Application.mouseY,
			textWidth + margin*2,
			kha.Assets.fonts.OpenSans.height(textSize) + margin*2*0.8);
		g2.font = kha.Assets.fonts.OpenSans;
		g2.fontSize = textSize;
		g2.color = tooltip.color;
		g2.drawString(tooltip.message, Application.mouseX +margin, Application.mouseY + margin*0.8);
	}
	
}