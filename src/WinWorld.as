package  
{
	import net.flashpunk.graphics.Image;
	import net.flashpunk.World;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	import net.flashpunk.Screen;
	
	/**
	 * ...
	 * @author Gary the Llama
	 */
	public class WinWorld extends World
	{
		[Embed(source = 'Resources/Win.png')]
		public static const Win:Class;
		
		[Embed(source = 'Resources/Donut.png')]
		public static const Donut:Class;
		
		public function WinWorld() 
		{
			FP.screen = new Screen;
			FP.screen.scale = 2;
			
			addGraphic(new Image(Win), 1, 40, 40);
			addGraphic(new Image(Donut), 1, 120 + 20, 120);
		}
		
		public override function update():void
		{
			if (Input.pressed(Key.ANY))
			{
				FP.world = new TitleWorld();
			}
		}
	}
}