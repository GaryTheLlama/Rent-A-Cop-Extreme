package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	
	/**
	 * ...
	 * @author Gary the Llama
	 */
	public class Clock extends Entity
	{
		public var text:Text
	
		public function Clock() 
		{
			this.text = new Text("", 20, 20);
			this.layer = 1;
			this.text.scale = 1;
			this.graphic = this.text;
		}
		
		public function SendText(text:String)
		{
			this.text = new Text("text", 20, 20);
		}
		
		override public function update():void
		{
			
		}
	}
}