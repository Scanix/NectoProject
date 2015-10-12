package ch.nectoria.entities;

import ch.nectoria.NP;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Spritemap;

/**
 * ...
 * @author Bianchi Alexandre

 */
class Coin extends Entity
{
	private var spPlayer:Spritemap;

	public function new(x:Float, y:Float) 
	{
		super(x, y-16);
		
		spPlayer = new Spritemap("graphics/tilemap.png", 16, 16);
		graphic = spPlayer;
		spPlayer.add("turn", [251, 252, 253, 254], 10, true);
		spPlayer.play("turn");
		
		setHitboxTo(graphic);
		layer = 4;
	}
	
	override public function update():Void {
		if (collide("player", x, y) != null) {
			NP.currentCoinsCount++;
			scene.remove(this);
		}
	}
	
}