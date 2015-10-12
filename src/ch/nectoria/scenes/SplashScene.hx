package ch.nectoria.scenes;

import com.haxepunk.graphics.Image;
import com.haxepunk.Scene;
import com.haxepunk.tweens.misc.Alarm;
import com.haxepunk.tweens.misc.VarTween;
import com.haxepunk.utils.Ease;
import com.haxepunk.HXP;

/**
 * ...
 * @author Bianchi Alexandre

 */
class SplashScene extends Scene
{
	private var splashImage:Image;

	public function new()
	{
		super();
	}
	
	override public function begin():Void {
		splashImage = new Image("graphics/splash/scanixgames.png");
		splashImage.alpha = 0;
		addGraphic(splashImage, -10, (HXP.screen.width - splashImage.width) / 2, (HXP.screen.height - splashImage.height) / 2);
		
		var splashTween:VarTween = new VarTween(fadeComplete);
		splashTween.tween(splashImage, "alpha", 1, 2.5, Ease.expoIn);
		addTween(splashTween, true);
		
	}
	
	private function fadeComplete(_):Void {
		var delaySplash:Alarm = new Alarm(2, alarmComplete, OneShot);
		addTween(delaySplash, true);
	}
	
	private function alarmComplete(_):Void {
		HXP.scene = new GameScene();
		HXP.screen.scale = 5;
		HXP.screen.color = 0x000000;
	}
	
	/*override public function end():Void {
		HXP.screen.scale = 4;
	}*/
}