package ch.nectoria.entities;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.Mask;
import com.haxepunk.tmx.TmxObject;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

/**
 * ...
 * @author ...
 */
class Sign extends Entity
{
	private var spPlayer:Spritemap;

	public function new(obj:TmxObject) 
	{
		super(obj.x, obj.y-16);
		
		spPlayer = new Spritemap("graphics/tilemap.png", 16, 16);
		graphic = spPlayer;
		spPlayer.add("idle", [38], 0, false);
		spPlayer.play("idle");
		
		setHitboxTo(graphic);
		layer = 4;
	}
	
	override public function update():Void {
		var e:Entity = collide("player", x, y);
		if (e != null && Input.pressed(Key.SPACE))
		{
			
		}
	}
	
}