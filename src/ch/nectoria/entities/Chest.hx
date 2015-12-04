package ch.nectoria.entities;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.Emitter;
import com.haxepunk.Mask;
import com.haxepunk.tmx.TmxObject;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import ch.nectoria.scenes.GameScene;

/**
 * ...
 * @author Bianchi Alexandre

 */
class Chest extends Physics
{
	private var spPlayer:Spritemap;
	private var coinEmitter:Emitter;

	public function new(obj:TmxObject) 
	{
		super(obj.x, obj.y-16);
		
		spPlayer = new Spritemap("graphics/tilemap.png", 16, 16);
		graphic = spPlayer;
		spPlayer.add("close", [34], 0, false);
		spPlayer.add("open", [50], 0, false);
		spPlayer.play("close");
		
		setHitboxTo(graphic);
		layer = 4;
	}
	
	override public function update():Void {
		var game:GameScene = cast(scene, GameScene);
		var e:Entity = collide("player", x, y);
        if (e != null && Input.pressed(Key.SPACE))
        {
            spPlayer.play("open");
			game.objectPoping(this.x,this.y);
        }
		super.update();
	}
	
}