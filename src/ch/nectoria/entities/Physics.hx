package ch.nectoria.entities;

import haxepunk.Entity;
import haxepunk.HXP;
import openfl.geom.Point;

/**
 * ...
 * @author Bianchi Alexandre

 */
class Physics extends Entity
{
	public var vx:Float = 0.0;
	public var vy:Float = 0.0;
	public var maxVx:Float = 10.0;
	public var maxVy:Float = 10.0;
	public var friction:Float = 0.70;
	public var inAir:Bool = true;
	public var collideLeft:Bool = false;
	public var collideRight:Bool = false;
	public var collideAbove:Bool = false;
	public var collideBelow:Bool = false;
	public var hasCollideRight:Bool = false;
	public var hasCollideLeft:Bool = false;
	public var gravity:Float = 0.5;
	
	public function new(x:Float, y:Float) 
	{
		previousPosition_ = new Point(x,y);
		super(x, y);
		
	}
	
	public override function update()
	{	
		if(vx > maxVx)
		{
			vx = maxVx;
		}
		if(vx < -maxVx)
		{
			vx = -maxVx;
		}
		if(vy > maxVy)
		{
			vy = maxVy;
		}
		if(vy < -maxVy)
		{
			vy = -maxVy;
		}
		if( (vx > 0 && vx < 0.1) || ( vx < 0 && vx > -0.1))
		{
			vx = 0.0;
		}
		if( (vy > 0 && vy < 0.2) || ( vy < 0 && vy > -0.2) )
		{
			vy = 0.0;
		}
		vx *= friction;
		var i:Int = 0;
		if(collide("solid", x, y) == null)
		{	
			inAir = true;
			collideAbove = false;
			collideRight = false;
			collideLeft = false;
			collideBelow = false;
		}
		while(i < Math.abs(vx))
		{
			var offsetX:Int;
			if(vx > 0)
			{
				offsetX = 1;
			}else if(vx < 0)
			{
				offsetX = -1;
			}else
			{
				offsetX = 0;
			}
			if(collide("solid", x + offsetX, y) == null)
			{
				previousPosition_.x = x;
				previousPosition_.y = y;
				x += offsetX;
				
			}else {
				vx = 0;
				
				if (previousPosition_.x <= x) {
					collideRight = true;
					hasCollideRight = true;
					hasCollideLeft = false;
				} else if (previousPosition_.x >= x) {
					collideLeft = true;
					hasCollideRight = false;
					hasCollideLeft = true;
				}
			}
			i ++;
		}
		var i2:Int = 0;
		while(i2 < Math.abs(vy))
		{
			var offsetY:Int;
			if(vy > 0)
			{
				offsetY = 1;
			}else if(vy < 0)
			{
				offsetY = -1;
			}else
			{
				offsetY = 0;
			}
			if(collide("solid", x, y + offsetY) == null)
			{
				y += offsetY;
			}else{
				if(vy > 0)
				{
					collideBelow = true;
				}else
				{
					collideAbove = true;
				}
				vy = 0;
				inAir = false;
			}
			i2++;
		}
		if(inAir)
		{
			vy += gravity;
		}
	}
	
	private var previousPosition_:Point; 
}