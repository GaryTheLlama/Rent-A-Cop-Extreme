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
	public class LoseWorld extends World
	{
		[Embed(source = 'Resources/Lose.png')]
		public static const Lose:Class;
		
		public function LoseWorld() 
		{
			FP.screen = new Screen;
			FP.screen.scale = 2;
			
			addGraphic(new Image(Lose), 1, 40, 40);
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