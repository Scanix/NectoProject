package ch.nectoria.ui;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.Graphiclist;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.graphics.Text;
import com.haxepunk.Mask;
import com.haxepunk.graphics.AnimatedTilemap;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

/**
 * ...
 * @author Bianchi Alexandre

 */
class MessageBox extends Entity
{
	private var tilemap:AnimatedTilemap;
	private var message:String;
	private var typewriter:String;
	private var test:String;
	private var text:Text;
	private var characterIndex:UInt = 0;
	private var positionText:Int = 1;
	private var numberLine:UInt = 1;
	private var paused:Bool = false;
	private var textTick:UInt = 0;
	private static inline var TEXT_SPEED:UInt = 1;

	public function new() 
	{
		super(0, 0);
		
		type = "messagebox";
		collidable = false;
		visible = true;
		layer = 1;
		
		text = new Text(message, 5, 5);
		text.font = "font/04B_03__.ttf";
		text.color = 0x000000;
		text.size = 8;
		text.scrollX = 0;
		text.scrollY = 0;
		text.addStyle("red", { color: 0xFF0000 });
		text.addStyle("big", { size: 16 });
		
		test = "bla\nbla";
		
		tilemap = new AnimatedTilemap("graphics/tilemap.png", 256, 48, 16, 16);
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
		
		graphic = new Graphiclist( );
        
        cast( graphic, Graphiclist ).add( tilemap );
		cast( graphic, Graphiclist ).add( text );
		
		// Pause the dialogue until it has been initialized with text.
		paused = true;
	}
	
	public function resume():Void
	{
		if (paused)
		{
			if (positionText >= message.length)
			{
				scene.remove(this);
				NP.displayingMessage = false;
				NP.frozenPlayer = false;
			}
			else
			{
				tilemap.setTile(tilemap.columns - 1, tilemap.rows - 1, 98);
				typewriter = "";
				positionText++;
				numberLine = 0;
				paused = false;
				textTick = 0;
			}
		}
	}
	
	public function create(textInput:String):Void
	{
		message = textInput;
		
		//reset box
		characterIndex = 0;
		positionText = 0;
		numberLine = 1;
		typewriter = "";
		
		// Begin dialogue.
		paused = false;
	}

	override public function update():Void
	{
		text.richText = typewriter;
		var char:String = message.charAt(positionText);
		if (textTick == 0 && !paused && positionText < message.length)
		{
			textTick = TEXT_SPEED;
			trace(char);
			if(char == "<"){
				typewriter += message.substring(positionText,message.indexOf('</red>')+5);
				positionText = typewriter.length;
			}
			if (char == '*')
			{
				// New line.
				if (numberLine == 4)
				{
					// There is more dialog. Show the indicator and wait.
					tilemap.setTile(tilemap.columns - 1, tilemap.rows - 1, 113);
					tilemap.animate([113, 114], 5);
					paused = true;
				}
				else
				{
					typewriter = typewriter.substring(0, positionText);
					typewriter += '\n';
					numberLine++;
					positionText++;
				}
			}
			else
			{
				if (positionText < message.length)
				{
					typewriter += message.charAt(positionText);
					text.updateBuffer();
					positionText++;
				}
			}
		}
		else if (positionText >= message.length)
		{
			paused = true;
		}
		else
		{
			textTick--;
		}
		text.updateBuffer();
		super.update();
	}
	
}