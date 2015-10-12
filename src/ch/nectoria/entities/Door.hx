package ch.nectoria.entities;

import ch.nectoria.NP;
import ch.nectoria.scenes.GameScene;

import com.haxepunk.Entity;
import com.haxepunk.tmx.TmxObject;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

/**
 * ...
 * @author Bianchi Alexandre

 */
class Door extends Entity
{
	private var spPlayer:Spritemap;
	public var levelTo(default,null):String;
	public var xTo(default,null):Int;
	public var yTo(default,null):Int;

	public function new(obj:TmxObject) 
	{
		super(obj.x, obj.y-16);
		
		spPlayer = new Spritemap("graphics/tilemap.png", 16, 16);
		graphic = spPlayer;
		spPlayer.add("close", [106], 0, false);
		spPlayer.play("close");
		
		levelTo = obj.custom.resolve("level");
		xTo = Std.parseInt(obj.custom.resolve("xTo"))*16;
		yTo = Std.parseInt(obj.custom.resolve("yTo"))*16-16;
		
		type = "door";
		setHitboxTo(graphic);
		layer = 4;
	}
	
}