package ch.nectoria.entities;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.Mask;
import com.haxepunk.tmx.TmxObject;
import com.haxepunk.graphics.Spritemap;

/**
 * ...
 * @author Bianchi Alexandre

 */
class Chest extends Entity
{
	private var spPlayer:Spritemap;

	public function new(obj:TmxObject) 
	{
		super(obj.x, obj.y);
		
		spPlayer = new Spritemap("graphics/tilemap.png", 16, 16);
		graphic = spPlayer;
		spPlayer.add("close", [2], 0, false);
		spPlayer.add("open", [19], 0, false);
		spPlayer.play("close");
		
		setHitboxTo(graphic);
	}
	
}