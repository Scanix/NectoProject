package ch.nectoria.entities;

import ch.nectoria.entities.Physics;
import ch.nectoria.NP;
import ch.nectoria.scenes.FightScene;
import ch.nectoria.scenes.GameScene;
import ch.nectoria.scenes.SplashScene;
import flash.geom.Point;

import haxepunk.Entity;
import haxepunk.graphics.Spritemap;
import haxepunk.input.Input;
import haxepunk.input.Key;
import haxepunk.HXP;
import haxepunk.graphics.Graphiclist;
import haxepunk.graphics.text.Text;
/**
 * ...
 * @author Bianchi Alexandre

 */
class Player extends Physics
{
	private var sprite:Spritemap;
	private var actionSign:Spritemap;
	public var speed:Float = 1.0;
	public var jumpSpeed:Float = 7.0;
	public var climbing:Bool = false;
	public var hasKey:Bool = false;
	private var text:Text;
	private var message:String;

	public function new(pos:Point, flip:Bool = false) 
	{
		super(pos.x, pos.y);
		
		//Debug functions
		
		//Animations & Graphics
		sprite = new Spritemap("graphics/entity/player32.png", 16, 32);
		sprite.add("idle", [8], 0, false);
		sprite.add("walk", [0, 1, 2, 3, 4, 5, 6, 7], 10, true);
		sprite.add("jump", [1], 0, false);
		sprite.add("fall", [3], 0, false);
		sprite.add("hurt", [4], 0, false);
		sprite.smooth = false;
		
		//Action Mark
		actionSign = new Spritemap("graphics/tilemap.png", 16, 16);
		actionSign.add("actionSign", [241], 0, false);
		actionSign.play("actionSign");
		actionSign.y = -16;
		actionSign.centerOrigin();
		
		graphic = new Graphiclist( );
		cast( graphic, Graphiclist ).add( sprite );
		cast( graphic, Graphiclist ).add( actionSign );
		
		sprite.scaleX = 1;
		sprite.centerOrigin();
		
		setHitbox(8, 23, 4, 7);
		type = "player";
		layer = 3;
	}
	
	override public function update():Void {
		var n:Entity = collide("npc", x, y);
		var s:Entity = collide("sign", x, y);
		var c:Entity = collide("chest", x, y);
		var d:Entity = collide("door", x, y);
		
		if (s != null || n !=null || c !=null || d !=null)
		{
			actionSign.visible = true;
		} else {
			actionSign.visible = false;
		}
		
		if (vx != 0) {
			sprite.play("walk");
		} else if (vy > 1) {
			sprite.play("fall");
		} else if (vy < -1) {
			sprite.play("jump");
		} else {
			sprite.play("idle");
		}
		
		if (!NP.frozenPlayer) {
			handleInput();
		}
		super.update();
	}
	
	public function handleInput():Void {
		if( Input.check("action") && !inAir && collideBelow)
		{
			this.jump();
		}
		if( Input.check("left") && !collideLeft)
		{
			this.moveLeft();
		}
		if( Input.check("right") && !collideRight)
		{
			this.moveRight();
		}
		/*if ( Input.pressed(Key.NUMPAD_8))
		{
			gainHealth();
		}
		if ( Input.pressed(Key.NUMPAD_7))
		{
			looseHealth();
		}*/
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