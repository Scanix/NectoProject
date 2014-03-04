package ch.nectoria;

import ch.nectoria.scenes.GameScene;
import ch.nectoria.scenes.SplashScene;

import com.haxepunk.Engine;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

import flash.display.Stage;

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
	}
	
	override public function update():Void {
		/*if (Input.pressed(Key.F)) HXP.fullscreen = !HXP.fullscreen;*/
		super.update();
	}

	override public function init()
	{
//#if debug
		HXP.console.enable();
//#end
#if (html5 || flash)
		HXP.screen.color = 0x000000;
#end
		HXP.screen.scale = 1;
		
		//Replace to SplashScene at the end
		HXP.scene = new GameScene();
	}

	public static function main() { new Main(); }

}