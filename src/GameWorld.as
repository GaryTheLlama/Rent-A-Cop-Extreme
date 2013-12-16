package  
{
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	import flash.display.DisplayObject;
	import flash.geom.ColorTransform;
	import flash.display.BlendMode;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Draw;
	import flash.geom.Rectangle;
	
	import net.flashpunk.graphics.TiledImage;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.masks.Grid;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.ScreenRetro;
	
	/**
	 * ...
	 * @author Gary the Llama
	 */
	public class GameWorld extends World
	{
		public var wallTiles:Tilemap;
		public var backgroundTiles:Tilemap;
		public var hallTiles:Tilemap;
		
		private const STATIC_TIME = 0.5;
		private var timer:Number;
		private var camKeyPressed = false;
		private var rec:Rec;
		private var clock:Clock;
		
		Global.dudes = 9; // 9
		
		[Embed(source = "Resources/vignette02.png")] private static var Vignette:Class;
		private var vignette:DisplayObject = new Vignette();
		
		[Embed(source = "Resources/film_grain.png")] private static var FilmGrain:Class;
		private var filmGrain:DisplayObject = new FilmGrain();
		
		public static var effects:BitmapData = new BitmapData(FP.width, FP.height, true, 0x00000000);
		
		public function GameWorld()
		{
			Global.Timer = 60.0;
		}
		
		override public function begin():void
		{
			super.begin();
			
			FP.screen = new ScreenRetro;
			FP.screen.scale = 2;
			
			timer = STATIC_TIME;
			
			backgroundTiles = new Tilemap(Resources.Hall, 960, 240, 16, 16); // 960, 240
			wallTiles = new Tilemap(Resources.Walls, 960, 240, 16, 16);
			hallTiles = new Tilemap(Resources.Hall, 320, 240, 16, 16);
			
			addGraphic(backgroundTiles, 100);
			addGraphic(wallTiles, 99);
			addGraphic(hallTiles, 100);
			
			var levelData:Class = Resources.Level01;
			LoadLevel(levelData);
			
			trace('cam1');
			Global.currentScreen = 1;
			FP.camera.x = 1;
			
			for (var i:int = 0; i < Global.dudes; i++)
			{
				if (i == 0)
				{
					add(new Dude(true));
				}
				else
				{
					add(new Dude(false));
				}
			}
			
			add(rec = new Rec(250, 10));
			
			clock = new Clock();
			add(clock);
		}
		
		override public function render():void
		{
			super.render();
			
			//effects.draw(vignette, null, new ColorTransform(1, 1, 1, 0.2), BlendMode.DARKEN);
			
			FP.buffer.draw(effects, null, new ColorTransform(1, 1, 1, 0.8), BlendMode.MULTIPLY);
			Draw.rect(FP.camera.x, FP.camera.y, FP.width, FP.height, 0x000000, 0.1);
		}
		
		override public function update():void
		{
			super.update();
			
			if (Global.Timer > 0)
			{
				Global.Timer -= 1 * FP.elapsed;
				//trace(Global.Timer);
				// TODO: Put real text here.
				
				if (camKeyPressed)
				{
					timer -= 1 * FP.elapsed;
					effects.noise(FP.rand(100), 1, 255, 7, true);
				}
				else
				{
					effects.noise(FP.rand(256), 100, 190, 7, true); // 100, 150, 7, true
				}
				
				if (timer < 0)
				{
					camKeyPressed = false;
					timer = 1;
				}
				
				if (Input.pressed(Key.DIGIT_1) && !camKeyPressed)
				{
					camKeyPressed = true;
					
					// Change to cam 1.
					Global.currentScreen = 1;
					FP.camera.x = 1;
					trace(FP.camera.x);
					
					rec.x = 250;
				}
				
				if (Input.pressed(Key.DIGIT_2) && !camKeyPressed)
				{
					camKeyPressed = true;
					
					// Change to cam 2.
					Global.currentScreen = 2;
					FP.camera.x = FP.width;
					trace(FP.camera.x);
					
					rec.x = FP.camera.x + 250;
				}
				
				if (Input.pressed(Key.DIGIT_3) && !camKeyPressed)
				{
					camKeyPressed = true;
					
					// Change to cam 3.
					Global.currentScreen = 3;
					FP.camera.x = FP.width * 2;
					trace(FP.camera.x);
					
					rec.x = FP.camera.x + 250;
				}
			}
		}
		
		public function LoadLevel(xmlData:Class):void
		{
			var data:ByteArray = new xmlData;
			var dataString:String = data.readUTFBytes(data.length);
			var xml:XML = new XML(dataString);
			
			// Load background tiles.
			/*for each (var tile:XML in xml.background[0].tile)
			{
				backgroundTiles.setTile(tile.@x / 16, tile.@y / 16, backgroundTiles.getIndex(tile.@tx / 16, tile.@ty / 16));
			}*/
			
			// Load hallway tiles.
			for each (var tile:XML in xml.background[0].tile)
			{
				backgroundTiles.setTile(tile.@x / 16, tile.@y / 16, backgroundTiles.getIndex(tile.@tx / 16, tile.@ty / 16));
			}
			
			// Load walls.
			for each (var tile:XML in xml.walls[0].tile)
			{
				wallTiles.setTile(tile.@x / 16, tile.@y / 16, wallTiles.getIndex(tile.@tx / 16, tile.@ty / 16));
			}
			
			// Load solid grid.
			for each (var tile:XML in xml.solid[0].rect)
			{
				add(new Solid(tile.@x, tile.@y, tile.@w, tile.@h));
			}
			
			// Load painting.
			for each (var tile:XML in xml.objects.painting)
			{
				add(new Painting(tile.@x, tile.@y));
			}
			
			for each (var tile:XML in xml.objects.painting02)
			{
				add(new Painting2(tile.@x, tile.@y));
			}
			
			for each (var tile:XML in xml.objects.painting03)
			{
				add(new Painting3(tile.@x, tile.@y));
			}
			
			for each (var tile:XML in xml.objects.sculpture)
			{
				add(new Sculpture(tile.@x, tile.@y));
			}
			
			for each (var tile:XML in xml.objects.statue)
			{
				add(new Statue(tile.@x, tile.@y));
			}
			
			// Load go button.
			for each (var tile:XML in xml.objects.go)
			{
				add(new GoButton(tile.@x, tile.@y));
			}
			
			// Load taze button.
			for each (var tile:XML in xml.objects.taze)
			{
				add(new TazeButton(tile.@x, tile.@y));
			}
			
			// Load kill button.
			for each (var tile:XML in xml.objects.kill)
			{
				add(new KillButton(tile.@x, tile.@y));
			}
			
			// Load diamond.
			for each (var tile:XML in xml.objects.diamond)
			{
				add(new Diamond(tile.@x, tile.@y));
			}
			
			// Load diamond display.
			for each (var tile:XML in xml.objects.display)
			{
				add(new DiamondDisplay(tile.@x, tile.@y));
			}
		}
	}
}