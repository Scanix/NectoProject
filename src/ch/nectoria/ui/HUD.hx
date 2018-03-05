package ch.nectoria.ui;

import ch.nectoria.NP;

import haxepunk.Entity;
import haxepunk.graphics.text.Text;
import haxepunk.HXP;

/**
 * ...
 * @author Bianchi Alexandre

 */
class HUD extends Entity
{
	private var text:Text;
	private var coinsCount:Int;

	public function new(x:Float = 0, y:Float = 0) 
	{
		super(x, y);
		type = "HUD";
		collidable = false;
		visible = true;
		layer = 1;
		
		text = new Text(NP.currentCoinsCount + " x Coins | " + NP.currentPlayerHealth + "/" + NP.maxPlayerHealth + " | " + NP.deadPlayer + "|" + NP.displayingMessage, 5, 5);
		text.font = "font/04B_03__.ttf";
		text.size = 8;
		graphic = text;
		graphic.scrollX = 0;
		graphic.scrollY = 0;
		
		coinsCount = NP.currentCoinsCount;
	}
	
	override public function update():Void {
		if (coinsCount != NP.currentCoinsCount) {
			text.text = NP.currentCoinsCount + " x Coins | " + NP.currentPlayerHealth + "/" + NP.maxPlayerHealth + " | " + NP.deadPlayer + "|" + NP.displayingMessage;
			text.updateBuffer();
			coinsCount = NP.currentCoinsCount;
		}
		text.updateBuffer();
		super.update();
	}
	
}