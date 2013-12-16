package  
{
	import net.flashpunk.graphics.Image;
	import net.flashpunk.World;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Gary the Llama
	 */
	public class TitleWorld extends World
	{
		[Embed(source = 'Resources/TitleScreen.png')]
		public static const Title:Class;
		
		public function TitleWorld() 
		{
			addGraphic(new Image(Title));
		}
		
		public override function update():void
		{
			if (Input.pressed(Key.ANY))
			{
				FP.world = new InstructionsWorld();
			}
		}
	}
}