package ch.nectoria.entities;

import ch.nectoria.entities.Physics;
import ch.nectoria.NP;
import ch.nectoria.scenes.GameScene;
import flash.geom.Point;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.HXP;

/**
 * ...
 * @author ...
 */
class NPC extends Physics
{
	private var spPlayer:Spritemap;
	public var speed:Float = 1.0;

	public function new(x:Float, y:Float, flip:Bool = false) 
	{
		super(x, y);
		
		//Animations & Graphics
		spPlayer = new Spritemap("graphics/entity/npc1.png", 16, 32);
		spPlayer.add("idle", [8], 0, false);
		spPlayer.add("speak", [8, 9], 2, true);
		spPlayer.add("walk", [0, 1, 2, 3, 4, 5, 6, 7], 10, true);
		spPlayer.add("jump", [1], 0, false);
		spPlayer.add("fall", [3], 0, false);
		spPlayer.add("hurt", [4], 0, false);
		
		graphic = spPlayer;
		spPlayer.flipped = flip;
		
		setHitbox(8, 23, -4, -9);
		type = "npc";
		layer = 3;
	}
	
	override public function update():Void {
		if (vx != 0) {
			spPlayer.play("walk");
		} else if (vy > 1) {
			spPlayer.play("fall");
		} else if (vy < -1) {
			spPlayer.play("jump");
		} else {
			spPlayer.play("speak");
		}
		
		if (!NP.frozenPlayer) {
			//handleInput();
		}
		super.update();
	}
	
}