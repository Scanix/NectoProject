package ch.nectoria;

import ch.nectoria.entities.Player;

import haxepunk.graphics.Image;
import haxepunk.graphics.Spritemap;
import haxepunk.tweens.misc.NumTween;
import haxepunk.tweens.misc.VarTween;
import haxepunk.HXP;

import flash.geom.Point;

/**
 * ...
 * @author Bianchi Alexandre

 */
class NP
{
	//Level
	public static var currentLvl:Int = 0;
	public static var levels:Array<String> = ["level0", "level1"];
	
	//Player
	public static var currentPlayerHealth:Int = 1;
	public static var maxPlayerHealth:Int = 3;
	public static var deadPlayer:Bool = false;
	public static var posPlayer:Point = new Point(100, 100);
	public static var frozenPlayer:Bool = false;
	
	//HUD
	public static var currentCoinsCount:Int = 0;
	public static var displayingMessage:Bool = false;
	
	//global access
	//public static var objectsSprite:Spritemap = new Spritemap("graphics/tilemap.png", 16, 16);
}