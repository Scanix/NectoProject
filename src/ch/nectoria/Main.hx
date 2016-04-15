package ch.nectoria;

import ch.nectoria.scenes.GameScene;
import ch.nectoria.scenes.SplashScene;

import com.haxepunk.Engine;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import openfl.display.StageQuality;

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
		/*if (Input.pressed(Key.F)) {
			HXP.screen.scale = 5;
			HXP.fullscreen = !HXP.fullscreen;
		}*/
		super.update();
	}
	
	override public function resize()
    {
        super.resize();
        //if (post != null) post.rebuild(); // must be after super.resize
    }
	
	override public function render()
    {
        //post.capture(); // must be before super.render
        super.render();
    }

	override public function init()
	{
#if debug
		HXP.console.enable(Key.DIGIT_9);
#end
#if (html5 || flash)
		HXP.screen.color = 0xffffff;
#end
		HXP.screen.scale = 1;
		HXP.stage.quality = StageQuality.LOW;
		HXP.screen.smoothing = false;
		/*
		post = new PostProcess("shaders/grain.frag");
		post.enable();
		*/
		//Replace to SplashScene at the end
		HXP.scene = new SplashScene();
	}

	public static function main() { new Main(); }

}