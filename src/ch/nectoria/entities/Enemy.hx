package ch.nectoria.entities;

import haxepunk.tmx.TmxObject;

/**
 * ...
 * @author Bianchi Alexandre
 */
class Enemy extends Physics
{

	public function new(obj:TmxObject) 
	{
		super(obj.x, obj.y);
		
	}
	
}