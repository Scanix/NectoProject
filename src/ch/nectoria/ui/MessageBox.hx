package ch.nectoria.ui;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.graphics.Text;
import com.haxepunk.Mask;
import com.haxepunk.graphics.Tilemap;

/**
 * ...
 * @author Bianchi Alexandre

 */
class MessageBox extends Entity
{
	private var tilemap:Tilemap;
	private var text:String;
	private var characterIndex:UInt = 0;
	private var columnIndex:UInt = 1;
	private var rowIndex:UInt = 2;
	private var paused:Bool = false;
	private var textTick:UInt = 0;
	private static inline var TEXT_SPEED:UInt = 5;

	public function new() 
	{
		type = "messagebox";
		collidable = false;
		visible = true;
		layer = 1;
		
		tilemap = new Tilemap("graphics/tilemap.png", 256, 48, 16, 16);
		tilemap.x = 0;
		tilemap.y = 0;
		tilemap.scrollX = 0;
		tilemap.scrollY = 0;
		
		// Set up frame.
		tilemap.setRect(1, 1, tilemap.columns - 2, 1, 81);
		// Corners
		tilemap.setTile(0, 0, 64);
		tilemap.setTile(tilemap.columns - 1, 0, 66);
		tilemap.setTile(0, tilemap.rows - 1, 96);
		tilemap.setTile(tilemap.columns - 1, tilemap.rows - 1, 98);
		// Borders
		tilemap.setRect(1, 0, tilemap.columns - 2, 1, 65);
		tilemap.setRect(1, tilemap.rows - 1, tilemap.columns - 2, 1, 97);
		tilemap.setRect(0, 1, 1, tilemap.rows - 2, 80);
		tilemap.setRect(tilemap.columns - 1, 1, 1, tilemap.rows - 2, 82);
		
		// Pause the dialogue until it has been initialized with text.
		paused = true;
		
		super(0, 0, tilemap);
	}
	
}