package ch.nectoria.entities;

import ch.nectoria.entities.Physics;
import ch.nectoria.NP;
import ch.nectoria.scenes.GameScene;

import haxepunk.Entity;
import haxepunk.graphics.Spritemap;
import haxepunk.input.Input;
import haxepunk.input.Key;
import haxepunk.HXP;
import haxepunk.tmx.TmxObject;

/**
 * ...
 * @author Bianchi Alexandre
 */
class NPC extends Physics
{
	private var sprite:Spritemap;
	public var speed:Float = .2;
	public var jumpSpeed:Float = 7.0;
	public var text:String;
	private var speaking:Bool = false;

	public function new(obj:TmxObject) 
	{
		super(obj.x, obj.y);
		
		//Animations & Graphics
		sprite = new Spritemap("graphics/entity/npc1.png", 16, 32);
		sprite.add("idle", [8], 0, false);
		sprite.add("speak", [8, 9], 5, true);
		sprite.add("walk", [0, 1, 2, 3, 4, 5, 6, 7], 10, true);
		sprite.add("jump", [1], 0, false);
		sprite.add("fall", [3], 0, false);
		sprite.add("hurt", [4], 0, false);
		
		graphic = sprite;
		text = obj.custom.resolve("text");
		sprite.scaleX = 1;
		sprite.centerOrigin();
		
		setHitbox(16, 23, 8, 7);
		type = "npc";
		layer = 3;
	}
	
	override public function update():Void {
		
		var e:Entity = collide("player", x, y);
		
		var game:GameScene = cast(scene, GameScene);
		if (e != null && Input.pressed("action") && !NP.displayingMessage)
		{
			game.showMessageBox(text);
			sprite.play("speak");
			speaking = true;
		}
		
		if (vx != 0) {
			sprite.play("walk");
		} else if (vy > 1) {
			sprite.play("fall");
		} else if (vy < -1) {
			sprite.play("jump");
		} else if (!speaking) {
			sprite.play("idle");
		} else {
			sprite.play("speak");
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
		sprite.scaleX = -1;
	}
	
	public function moveRight():Void
	{
		vx += speed;
		if(collideLeft)
		{
			collideLeft = false;
		}
		sprite.scaleX = 1;
	}
	
}