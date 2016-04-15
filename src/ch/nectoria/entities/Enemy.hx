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
import com.haxepunk.tmx.TmxObject;

/**
 * ...
 * @author Bianchi Alexandre
 */
class Enemy extends Physics
{
	private var spPlayer:Spritemap;
	public var speed:Float = .2;
	public var jumpSpeed:Float = 7.0;
	public var text:String;
	private var speaking:Bool = false;

	public function new(obj:TmxObject) 
	{
		super(obj.x, obj.y);
		
		//Animations & Graphics
		spPlayer = new Spritemap("graphics/entity/enemy_shadow.png", 16, 16);
		spPlayer.add("idle", [8], 0, false);
		spPlayer.add("walk", [0, 1, 2, 3, 4, 5, 6, 7], 10, true);
		spPlayer.add("jump", [1], 0, false);
		spPlayer.add("fall", [3], 0, false);
		spPlayer.add("hurt", [4], 0, false);
		
		graphic = spPlayer;
		text = obj.custom.resolve("text");
		spPlayer.flipped = false;
		
		setHitbox(16, 7, 0, -9);
		type = "enemy";
		layer = 3;
	}
	
	override public function update():Void {
		
		var e:Entity = collide("player", x, y);
		var game:GameScene = cast(scene, GameScene);
		
		if (e != null)
		{
			game.beginFight();
		}
		
		if (vx != 0) {
			spPlayer.play("walk");
		} else if (vy > 1) {
			spPlayer.play("fall");
		} else if (vy < -1) {
			spPlayer.play("jump");
		} else if (!speaking) {
			spPlayer.play("idle");
		} else {
			spPlayer.play("speak");
		}
		
		if (!NP.frozenPlayer) {
			if(!hasCollideRight){
				moveRight();
			} else if (!hasCollideLeft){
				moveLeft();
			}
		}
		super.update();
	}
	
	public function jump():Void
	{
		vy -= jumpSpeed;
		inAir = true;
	}
	
	public function moveLeft():Void
	{
		vx -= speed;
		if(collideRight)
		{
			collideRight = false;
		}
		spPlayer.flipped = true;
	}
	
	public function moveRight():Void
	{
		vx += speed;
		if(collideLeft)
		{
			collideLeft = false;
		}
		spPlayer.flipped = false;
	}
	
}