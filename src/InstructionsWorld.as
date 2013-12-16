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
	public class InstructionsWorld extends World
	{
		[Embed(source = 'Resources/Instructions.png')]
		public static const Title:Class;
		
		public function InstructionsWorld() 
		{
			addGraphic(new Image(Title));
		}
		
		public override function update():void
		{
			if (Input.pressed(Key.ANY))
			{
				FP.world = new GameWorld();
			}
		}
	}
}