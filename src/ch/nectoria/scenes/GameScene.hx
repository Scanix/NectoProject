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

/**
 * ...
 * @author Bianchi Alexandre

 */
class GameScene extends Scene
{	
	private var player:Player;
	private var music:Sfx;
	
	private var paused : Bool = false;
	
	private var counter:Text;
	private var backdrop1:Backdrop;
	
	//Fade Black
	private var fade:Image;
	private var fadeTween:NumTween;
	
	override public function begin():Void {
		// DON'T FORGET TO REMOVE BITCH !
		HXP.screen.scale = 4;
		
		// Set level to 0
		NP.currentLvl = 0;
		
		load();
		
		// Fade to black
		fade = Image.createRect(HXP.screen.width, HXP.screen.height, 0);
		fade.scrollX = fade.scrollY = 0;
		addGraphic(fade, 0).type = "keep";
		fadeTween = new NumTween(fadeComplete);
		addTween(fadeTween);
		fadeTween.tween(1, 0, 2);
	}
	
	private function load():Void {
		removeAll();
		
		//Backdrop
		backdrop1 = new Backdrop("graphics/back.png", true, false);
		addGraphic(backdrop1);
		
		// Map
		var map:TmxMap = new TmxMap(openfl.Assets.getText("maps/" + NP.levels[NP.currentLvl] + ".tmx"));
		var order:Array<String> = ["background", "collide"];
		var map_e = new TmxEntity(map);
		map_e.loadGraphic("graphics/tilemap.png", order);
		map_e.loadMask("collide", "solid");
		
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
		
		//TODO: LOAD THIS IN FRONT
		//map_e.loadGraphic("graphics/tilemap.png", ["front"]);
		
		// Add HUD
		add(new HUD());
	}
	
	override public function update():Void {
		// Camera
		HXP.setCamera(player.x + player.halfWidth - HXP.halfWidth, 60);
		
		if (fadeTween != null) {
			fade.alpha = fadeTween.value;
		}
		
		if (Input.pressed(Key.ESCAPE)) togglePause();
		
		if (!paused) {
			super.update();
		}
	}
	
	public function fadeComplete(_):Void {
		if (fadeTween.value == 1)
		{
			// load next level
			fadeTween.tween(1, 0, 0.5);
			//loadLevel();
		}
	}
	
	public function switchLevel(xTo:Int, yTo:Int, levelTo:Int):Void {
		if (NP.currentLvl == levelTo) {
			player.x = xTo;
			player.y = yTo;
		} else {
			NP.posPlayer.x = xTo;
			NP.posPlayer.y = yTo;
			toggleLevel(levelTo);
		}
	}
	
	public function loadLevel():Void {
		if (NP.currentLvl < NP.levels.length) {
			load();
		} else {
			NP.currentLvl = 0;
			load();
		}
	}
	
	private function togglePause():Void {
		paused = !paused;
	}
	
	public function toggleLevel(levelTo:Int):Void {
		NP.currentLvl = levelTo;
		
		/*if (NP.currentLvl < NP.levels.length) {
			load();
		} else {
			NP.currentLvl = 0;
			load();
		}*/
		fadeTween.tween(0, 1, 0.3);
	}
}