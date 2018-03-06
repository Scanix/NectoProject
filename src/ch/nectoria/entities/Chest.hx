package ch.nectoria.entities;

import haxepunk.Entity;
import haxepunk.Graphic;
import haxepunk.graphics.emitter.Emitter;
import haxepunk.Mask;
import haxepunk.tmx.TmxObject;
import haxepunk.graphics.Spritemap;
import haxepunk.input.Input;
import haxepunk.input.Key;
import ch.nectoria.scenes.GameScene;

/**
 * ...
 * @author Bianchi Alexandre

 */
class Chest extends Physics
{
	private var sprite:Spritemap;
	private var coinEmitter:Emitter;

	public function new(obj:TmxObject) 
	{
		super(obj.x, obj.y-16);
		
		sprite = new Spritemap("graphics/tilemap.png", 16, 16);
		sprite.smooth = false;
		sprite.add("close", [34], 0, false);
		sprite.add("open", [50], 0, false);
		sprite.play("close");

		graphic = sprite;
		
		setHitboxTo(graphic);
		type = 'chest';
		layer = 4;
	}
	
	override public function update():Void {
		var game:GameScene = cast(scene, GameScene);
		var e:Entity = collide("player", x, y);
        if (e != null && Input.pressed("action"))
        {
            sprite.play("open");
			game.objectPoping(this.x,this.y);
        }
		super.update();
	}
	
}