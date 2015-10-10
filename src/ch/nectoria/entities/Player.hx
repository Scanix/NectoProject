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
 * @author Bianchi Alexandre

 */
class Player extends Physics
{
	private var spPlayer:Spritemap;
	public var speed:Float = 1.0;
	public var jumpSpeed:Float = 10.0;
	public var climbing:Bool = false;
	public var hasKey:Bool = false;

	public function new(pos:Point, flip:Bool = false) 
	{
		super(pos.x, pos.y);
		
		//Debug functions
		
		//Animations & Graphics
		spPlayer = new Spritemap("graphics/entity/player.png", 16, 16);
		spPlayer.add("idle", [8], 0, false);
		spPlayer.add("walk", [0, 1, 2, 3, 4, 5, 6, 7], 10, true);
		spPlayer.add("jump", [1], 0, false);
		spPlayer.add("fall", [3], 0, false);
		spPlayer.add("hurt", [4], 0, false);
		
		graphic = spPlayer;
		spPlayer.flipped = flip;
		
		setHitbox(8, 13, -4, -3);
		type = "player";
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
			spPlayer.play("idle");
		}
		
		if (!NP.frozenPlayer) {
			handleInput();
		}
		super.update();
	}
	
	public function handleInput():Void {
		if( (Input.check(Key.UP) || Input.check(Key.W)) && !inAir && collideBelow)
		{
			this.jump();
		}
		if( (Input.check(Key.LEFT) || Input.check(Key.A)) && !collideLeft)
		{
			this.moveLeft();
		}
		if( (Input.check(Key.RIGHT) || Input.check(Key.D)) && !collideRight)
		{
			this.moveRight();
		}
		if ( Input.pressed(Key.NUMPAD_8))
		{
			gainHealth();
		}
		if ( Input.pressed(Key.NUMPAD_7))
		{
			looseHealth();
		}
		
		var game:GameScene = cast(scene, GameScene);
		var e:Entity = collide("door", x, y);
        if (e != null && Input.pressed(Key.SPACE))
        {
            var d:Door = cast(e, Door);
			game.switchLevel(d.xTo, d.yTo, d.levelTo);
        }
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
	
	public function gainHealth():Void {
		if (NP.currentPlayerHealth < NP.maxPlayerHealth) {
			NP.currentPlayerHealth++;
		}
	}
	
	public function looseHealth():Void {
		if (NP.currentPlayerHealth > 1) {
			NP.currentPlayerHealth--;
		} else {
			this.kill();
		}
	}
	
	public function kill():Void {
		NP.deadPlayer = true;
		scene.remove(this);
	}
}