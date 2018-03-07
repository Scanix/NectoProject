package ch.nectoria.entities;

import ch.nectoria.scenes.GameScene;
import ch.nectoria.NP;

import haxepunk.Entity;
import haxepunk.Graphic;
import haxepunk.graphics.Spritemap;
import haxepunk.Mask;
import haxepunk.tmx.TmxObject;
import haxepunk.input.Input;
import haxepunk.input.Key;
import haxepunk.utils.Log;

/**
 * ...
 * @author ...
 */
class Sign extends Entity
{
	private var sprite:Spritemap;
	public var text:String;

	public function new(obj:TmxObject) 
	{
		super(obj.x, obj.y-16);

		text = obj.custom.resolve("text");
		
		sprite = new Spritemap("graphics/tilemap.png", 16, 16);
		sprite.smooth = false;
		sprite.add("idle", [38], 0, false);
		sprite.play("idle");

		graphic = sprite;
		
		setHitbox(16, 16);
		type = "sign";
		layer = 4;
	}
	
	override public function update():Void {
		var e:Entity = collide("player", x, y);
		
		var game:GameScene = cast(scene, GameScene);
		if (e != null && Input.pressed("action") && !NP.displayingMessage)
		{
			game.showMessageBox(text);
		}
	}
	
}