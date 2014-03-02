package ch.nectoria.scenes;

import ch.nectoria.entities.Chest;
import ch.nectoria.entities.Player;
import ch.nectoria.entities.Coin;
import ch.nectoria.NP;
import ch.nectoria.ui.HUD;
import com.haxepunk.Sfx;

import com.haxepunk.graphics.Text;
import com.haxepunk.Scene;
import com.haxepunk.HXP;
import com.haxepunk.tmx.TmxEntity;
import com.haxepunk.tmx.TmxMap;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

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
	
	override public function begin():Void {
		// DON'T FORGET TO REMOVE BITCH !
		HXP.screen.scale = 4;
		
		// Set level to 0
		NP.currentLvl = 0;
		
		load();
	}
	
	private function load():Void {
		removeAll();
		
		add(new HUD());
		
		var map:TmxMap = new TmxMap(openfl.Assets.getText("maps/" + NP.levels[NP.currentLvl] + ".tmx"));
		var order:Array<String> = ["background", "collide"];
		var map_e = new TmxEntity(map);
		map_e.loadGraphic("graphics/tilemap.png", order);
		map_e.loadMask("collide", "solid");
		
		add(map_e);
		
		for (object in map.getObjectGroup("objects").objects) {
			switch(object.type) {
				case "coin":
					add(new Coin(object.x, object.y));
				case "start":
					add(player = new Player(object.x, object.y));
				case "chest":
					add(new Chest(object));
				default:
					trace("unknow type: " + object.type);
			}
		}
		
		add(new HUD());
	}
	
	override public function update():Void {
		// Camera
		HXP.setCamera(player.x + player.halfWidth - HXP.halfWidth, 60);
		
		if (Input.pressed(Key.ESCAPE)) togglePause();
		
		if (Input.pressed(Key.N)) nextLevel();
		
		if (!paused) {
			super.update();
		}
	}
	
	private function togglePause():Void {
		paused = !paused;
	}
	
	public function nextLevel():Void {
		NP.currentLvl++;
		
		if (NP.currentLvl < NP.levels.length) {
			load();
		} else {
			NP.currentLvl = 0;
			load();
		}
	}
}