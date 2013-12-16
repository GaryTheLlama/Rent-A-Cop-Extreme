package  
{
	import net.flashpunk.Entity;
	
	/**
	 * ...
	 * @author Gary the Llama
	 */
	public class Solid extends Entity
	{
		public function Solid(x:int, y:int, w:int, h:int)
		{
			super(x, y);
			
			type = "solid";
			setHitbox(w, h);
			visible = false;
		}
	}
}