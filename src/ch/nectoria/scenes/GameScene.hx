package ch.nectoria.scenes;

import ch.nectoria.entities.Chest;
import ch.nectoria.entities.Door;
import ch.nectoria.entities.Player;
import ch.nectoria.entities.Coin;
import ch.nectoria.NP;
import ch.nectoria.ui.HUD;

import com.haxepunk.graphics.Backdrop;
import com.haxepunk.graphics.Image;
import com.haxepunk.Sfx;
import com.haxepunk.graphics.Text;
import com.haxepunk.Scene;
import com.haxepunk.HXP;
import com.haxepunk.tmx.TmxEntity;
import com.haxepunk.tmx.TmxMap;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.graphics.atlas.AtlasData;
import com.haxepunk.tweens.misc.NumTween;
import com.haxepunk.utils.Data;
import com.haxepunk.Entity;

import openfl.Assets;

/**
 * ...
 * @author Bianchi Alexandre

 */
class GameScene extends Scene
{	
	private var player:Player;
	public static var levelWidth:Int;
	public static var levelHeight:Int;
	
	private var paused : Bool = false;
	
	private var counter:Text;
	private var backdrop1:Backdrop;
	
	public function new() {
		super();
		
		// TODO: MUSIC MANAGER
	}
	
	public function fadeComplete(_):Void {
		if (fadeTween.value == 1)
		{
			// Load next level
			loadLevel(currentLvl);
			fadeTween.tween(1, 0, 0.5);
			NP.frozenPlayer = false;
		}
	}
	
	override public function begin():Void {
		// DON'T FORGET TO REMOVE BITCH !
		HXP.screen.scale = 5;
		
		load();
		
		// Fade to black
		fade = Image.createRect(HXP.screen.width, HXP.screen.height, 0, 1);
		fade.scrollX = fade.scrollY = 0;
		addGraphic(fade, 0).type = "keep";
		fadeTween = new NumTween(fadeComplete);
		addTween(fadeTween);
		fadeTween.tween(1, 0, 2);
	}
	
	public function restart():Void {
		
	}
	
	private function load():Void {
		Data.load("Current");
		currentLvl = Data.readString("level", "corcelles");
		loadLevel(currentLvl);
	}
	
	public function save()
	{
		Data.write("level", currentLvl);
//		player.saveData();
		Data.save("Current");
	}
	
	private function getLevelData(id:String):String {
		var level:String = Assets.getText("maps/" + id + "/level.tmx");
		if (level != null)
			return level;
		return Assets.getText("maps/" + id + "/level.tmx");
	}
	
	private function loadLevel(id:String):Void {
		var entities:Array<Entity> = new Array<Entity>();
		getAll(entities);
		for (entity in entities) {
			if (entity.type != "keep")
				remove(entity);
		}
		
		// Backdrop
		/*backdrop1 = new Backdrop("graphics/back.png", true, true);
		backdrop1.relative;
		addGraphic(backdrop1, 6);*/
		
		var data:String = getLevelData(currentLvl);
		
		// Map
		var map:TmxMap = new TmxMap(data);
		var order:Array<String> = ["background", "between", "collide"];
		var map_e = new TmxEntity(map);
		map_e.loadGraphic("graphics/tilemap.png", order);
		map_e.loadMask("collide", "solid");
		map_e.layer = 5;
		
		mapWidth = map_e.width;
		mapHeight = map_e.height;
		
		add(map_e);
		
		// Load for objects
		for (object in map.getObjectGroup("objects").objects) {
			switch(object.type) {
				case "coin":
					add(new Coin(object.x, object.y));
				case "door":
					add(new Door(object));
				case "chest":
					add(new Chest(object));
				default:
					trace("unknow type: " + object.type);
			}
		}
		
		add(player = new Player(NP.posPlayer));
		
		var map_f = new TmxEntity(map);
		map_f.loadGraphic("graphics/tilemap.png", ["front"]);
		map_f.layer = 2;
		add(map_f);
		
		// Add HUD
		add(new HUD());
	}
	
	override public function update():Void {
		// Camera
		if (mapHeight > HXP.height) {
			HXP.setCamera(player.x + player.halfWidth - HXP.halfWidth, 60);
		} else {
			HXP.setCamera((HXP.halfWidth - mapWidth) / 2, (HXP.halfHeight - mapHeight) / 2);
		}
		
		if (fadeTween != null) {
			fade.alpha = fadeTween.value;
		}
		
		if (Input.pressed(Key.ESCAPE)) togglePause();
		
		if (!paused) {
			super.update();
		}
	}
	
	public function switchLevel(xTo:Int, yTo:Int, levelTo:String):Void {
		if (currentLvl == levelTo) {
			player.x = xTo;
			player.y = yTo;
		} else {
			currentLvl = levelTo;
			NP.posPlayer.x = xTo;
			NP.posPlayer.y = yTo;
			NP.frozenPlayer = true;
			fadeTween.tween(0, 1, 0.5);
		}
	}
	
	private function togglePause():Void {
		paused = !paused;
	}
	
	// Level Info
	private var currentLvl:String;
	private var mapWidth:Int;
	private var mapHeight:Int;
	// Switch Level
	private var nextLevel:String;
	
	// Fade Black
	private var fade:Image;
	private var fadeTween:NumTween;
}