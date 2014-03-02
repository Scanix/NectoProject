package ch.nectoria.entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.HXP;
import ch.nectoria.entities.Physics;

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

	public function new(x:Float, y:Float, flip:Bool = false) 
	{
		super(x, y);
		
		//Debug functions
		//HXP.console.watch(["Player.vx", "Player.vy"]);
		
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
		layer = -1;
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
		
		handleInput();
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