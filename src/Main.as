package 
{
	import net.flashpunk.FP;
	import net.flashpunk.Engine;
	import net.flashpunk.ScreenRetro;
	
	/**
	 * ...
	 * @author Gary the Llama
	 */
	public class Main extends Engine
	{
		public function Main():void
		{
			super(320, 240, 60, false);
			
			FP.screen.scale = 2;
			FP.world = new TitleWorld();
		}
		
		override public function init() : void
		{
			//FP.console.enable();
		}
	}
}