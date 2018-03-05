package ch.nectoria.entities;

import ch.nectoria.NP;

import haxepunk.Entity;
import haxepunk.graphics.Spritemap;

/**
 * ...
 * @author Bianchi Alexandre

 */
class Coin extends Physics
{
	private var sprite:Spritemap;

	public function new(x:Float, y:Float) 
	{
		super(x, y-16);
		
		sprite = new Spritemap("graphics/tilemap.png", 16, 16);
		graphic = sprite;
		sprite.add("turn", [251, 252, 253, 254], 10, true);
		sprite.play("turn");
		type = "coin";
		
		setHitbox(7, 9, -4, -4);
		layer = 4;
	}
	
	override public function update():Void {
		if (collide("player", x, y) != null) {
			NP.currentCoinsCount++;
			scene.remove(this);
		}
		
		super.update();
	}
	
}