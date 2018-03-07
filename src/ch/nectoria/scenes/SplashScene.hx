package ch.nectoria.scenes;

import haxepunk.HXP;
import haxepunk.Scene;
import haxepunk.graphics.Image;
import haxepunk.graphics.text.Text;
import haxepunk.tweens.misc.Alarm;
import haxepunk.tweens.misc.VarTween;
import haxepunk.utils.Ease;

/**
 * ...
 * @author Bianchi Alexandre

 */
class SplashScene extends Scene
{
	private var splashImage:Image;
	private var versionText:Text;

	public function new()
	{
		super();
	}
	
	override public function begin():Void {
		versionText = new Text("Version 0.2.1",2,2);
		versionText.color = 0x000000;
		

#if !flash
		var base = Image.createRect(HXP.width, HXP.height, 0xFFFFFF, 1);
		base.color = 0xFFFFFF;
		base.scrollX = base.scrollY = 0;
		addGraphic(base).layer = 100;    // set the layer to a value that's behind other onscreen objects
#end

		splashImage = new Image("graphics/splash/scanixgames.png");
		splashImage.alpha = 0;
		addGraphic(splashImage, -10, (HXP.screen.width - splashImage.width) / 2, (HXP.screen.height - splashImage.height) / 2);
		addGraphic(versionText);
		
		var splashTween:VarTween = new VarTween();
		splashTween.tween(splashImage, "alpha", 1, 2.5, Ease.expoIn);
		splashTween.onComplete.bind(fadeComplete);
		addTween(splashTween, true);
		
	}
	
	private function fadeComplete():Void {
		var delaySplash:Alarm = new Alarm(2, OneShot);
		delaySplash.onComplete.bind(alarmComplete);
		addTween(delaySplash, true);
	}
	
	private function alarmComplete():Void {
		HXP.scene = new GameScene();
		HXP.screen.color = 0x000000;
	}

}
