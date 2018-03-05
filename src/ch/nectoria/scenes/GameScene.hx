package ch.nectoria.scenes;

import ch.nectoria.NP;
import ch.nectoria.ui.HUD;
import ch.nectoria.ui.MessageBox;
import ch.nectoria.entities.Chest;
import ch.nectoria.entities.Door;
import ch.nectoria.entities.Player;
import ch.nectoria.entities.Coin;
import ch.nectoria.entities.Sign;
import ch.nectoria.entities.NPC;

import haxepunk.graphics.tile.Backdrop;
import haxepunk.graphics.Image;
import haxepunk.graphics.text.Text;
import haxepunk.graphics.atlas.TileAtlas;
import haxepunk.Scene;
import haxepunk.HXP;
import haxepunk.tmx.TmxEntity;
import haxepunk.tmx.TmxMap;
import haxepunk.input.Input;
import haxepunk.tweens.misc.NumTween;
import haxepunk.utils.Data;
import haxepunk.Entity;
import haxepunk.screen.UniformScaleMode;

import openfl.Assets;

/**
 * ...
 * @author Bianchi Alexandre

 */
class GameScene extends Scene
{	
	private var player:Player;
	private var messageBox:MessageBox;
	private var tileset:TileAtlas;

	public static var levelWidth:Int;
	public static var levelHeight:Int;
	
	private var paused : Bool = false;
	
	private var counter:Text;
	private var backdrop1:Backdrop;
	
	public function new() {
		super();
		
		// TODO: MUSIC MANAGER
	}
	
	public function fadeComplete():Void {
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

		// Prepare TileSet
		tileset = new TileAtlas("graphics/tilemap.png", 16, 16);

		// New way to zoomIn
		HXP.screen.scaleMode = new UniformScaleMode(UniformScaleType.ZoomIn, true);
		HXP.screen.scaleMode.setBaseSize(256, 144);
		HXP.resize(HXP.windowWidth, HXP.windowHeight);

		load();

		// Fade to black
		fade = Image.createRect(HXP.screen.width, HXP.screen.height, 0, 1);
		fade.scrollX = fade.scrollY = 0;
		addGraphic(fade, 0).type = "keep";
		fadeTween = new NumTween();
		fadeTween.onComplete.bind(fadeComplete);
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
		backdrop1 = new Backdrop("graphics/bg.png", true, false);
		backdrop1.scrollX = 0.1;
		addGraphic(backdrop1, 6);
		
		var data:String = getLevelData(currentLvl);
		
		// Map
		var map:TmxMap = new TmxMap(data);
		var order:Array<String> = ["background", "between", "collide"];
		var map_e = new TmxEntity(map);
		map_e.loadGraphic(tileset, order);
		map_e.loadMask("collide", "solid");
		map_e.layer = 5;
		
		mapWidth = map_e.width;
		mapHeight = map_e.height;
		
		add(map_e);
		
		// Load for objects
		for (object in map.getObjectGroup("objects").objects) {
			switch(object.gid) {
				case 254:
					add(new Coin(object.x, object.y));
				case 107:
					add(new Door(object));
				case 35:
					add(new Chest(object));
				case 39:
					add(new Sign(object));
				case 240:
					add(new NPC(object));
				default:
					trace("unknow type: " + object.type);
			}
		}
		
		add(player = new Player(NP.posPlayer));
		
		var map_f = new TmxEntity(map);
		map_f.loadGraphic(tileset, ["front"]);
		map_f.graphic.smooth = false;
		map_f.layer = 2;
		add(map_f);
		
		// Add HUD
		add(new HUD());
	}
	
	/**
	 * Display dialogue to the text box.
	 * @param	dialogue The dialogue to display.
	 */
	public function showMessageBox(text:String):Void
	{
		add(messageBox = new MessageBox());
		messageBox.create(text);
		NP.frozenPlayer = true;
		NP.displayingMessage = true;
	}
	
	override public function update():Void {
		if (messageBox != null && messageBox.scene == this )
		{
			if (Input.released("action"))
			{
				messageBox.resume();
			}
		}
		// Camera
		if (mapHeight > HXP.height) {
			HXP.setCamera(player.x + player.halfWidth - HXP.halfWidth, 60);
		} else {
			HXP.setCamera((HXP.halfWidth - mapWidth) / 2, (HXP.halfHeight - mapHeight) / 2);
		}
		
		if (fadeTween != null) {
			fade.alpha = fadeTween.value;
		}
		
		if (Input.pressed("pause")) togglePause();
		
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
	
	public function objectPoping(x:Float, y:Float) {
		for (i in 0...20)
		{
			add(new Coin(x, y));
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