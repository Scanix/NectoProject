package ch.nectoria.scenes;

import ch.nectoria.entities.Player;
import ch.nectoria.ui.MessageBox;
import com.haxepunk.Scene;
import com.haxepunk.graphics.Backdrop;
import com.haxepunk.tmx.TmxMap;
import com.haxepunk.tmx.TmxEntity;
import openfl.Assets;
import openfl.geom.Point;

/**
 * ...
 * @author ...
 */
class FightScene extends Scene
{
	private var player:Player;
	private var messageBox:MessageBox;
	public static var levelWidth:Int;
	public static var levelHeight:Int;
	
	private var backdrop:Backdrop;
	
	// Level Info
	private var currentLvl:String;
	private var mapWidth:Int;
	private var mapHeight:Int;

	public function new() 
	{
		super();
		
	}
	
	override public function begin():Void {
		//Map
		var map:TmxMap = new TmxMap(Assets.getText("maps/fight/level.tmx"));
		var order:Array<String> = ["collide"];
		var map_e = new TmxEntity(map);
		map_e.loadGraphic("graphics/tilemap.png", order);
		map_e.loadMask("collide");
		map_e.layer = 5;
		
		mapWidth = map_e.width;
		mapHeight = map_e.height;
		
		add(map_e);
		
		//Player
		add(player = new Player(new Point(32,32)));
	}
	
}