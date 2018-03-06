package ch.nectoria.entities;

import ch.nectoria.NP;
import ch.nectoria.scenes.GameScene;
import haxepunk.Graphic;

import haxepunk.Entity;
import haxepunk.tmx.TmxObject;
import haxepunk.graphics.Spritemap;
import haxepunk.input.Input;
import haxepunk.input.Key;

/**
 * ...
 * @author Bianchi Alexandre

 */
class Door extends Entity
{
	private var sprite:Spritemap;
	public var levelTo(default,null):String;
	public var xTo(default,null):Int;
	public var yTo(default,null):Int;

	public function new(obj:TmxObject) 
	{
		super(obj.x, obj.y-16);
		
		sprite = new Spritemap("graphics/tilemap.png", 16, 16);
		sprite.smooth = false;
		sprite.add("close", [106], 0, false);
		sprite.play("close");
		graphic = sprite;
		
		levelTo = obj.custom.resolve("level");
		xTo = Std.parseInt(obj.custom.resolve("xTo"))*16;
		yTo = Std.parseInt(obj.custom.resolve("yTo"))*16-16;
		
		setHitboxTo(graphic);
		type = "door";
		layer = 4;
	}
	
	override public function update():Void {
		if (!NP.frozenPlayer) {
			handleInput();
		}
		super.update();
	}
	
	public function handleInput():Void {
		var game:GameScene = cast(scene, GameScene);
		var e:Entity = collide("player", x, y);
        if (e != null && Input.pressed("action"))
        {
			game.switchLevel(this.xTo, this.yTo, this.levelTo);
        }
	}
	
}