package ch.nectoria;

import ch.nectoria.scenes.GameScene;
import ch.nectoria.scenes.SplashScene;

import haxepunk.Engine;
import haxepunk.HXP;
import haxepunk.input.Input;
import haxepunk.input.Key;
import haxepunk.debug.Console;

class Main extends Engine
{
	public function new():Void {
		super(1280, 720, 60, false);
#if ios
		Stage.setFixedOrientation( -1);
		Stage.shouldRotateInterface = function (orientation:Int):Bool {
			return (orientation == Stage.OrientationLandscapeLeft || orientation == Stage.OrientationLandscapeRight);
		}	
#end
		Key.define("left", [Key.LEFT, Key.A]);
        Key.define("right", [Key.RIGHT, Key.D]);
		Key.define("up", [Key.UP, Key.W]);
        Key.define("down", [Key.DOWN, Key.S]);
		Key.define("action", [Key.SPACE]);
		Key.define("pause", [Key.ESCAPE]);
	}

	override public function init()
	{
#if debug
		Console.enable();
#end
#if (html5)
		HXP.screen.color = 0xffffff;
#end
		//Replace to SplashScene at the end
		HXP.scene = new SplashScene();
	}

	public static function main() { new Main(); }

}