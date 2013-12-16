package  
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Gary the Llama
	 */
	public class Sculpture extends Entity
	{
		public var sprite:Spritemap;
		
		public function Sculpture(x:int, y:int)
		{
			this.x = x;
			this.y = y;
			
			this.sprite = new Spritemap(Resources.Sculpture, 16, 56);
			this.sprite.scale = 1.5;
			this.type = "sculpture";
			this.graphic = sprite;
			this.layer = -1;
			this.setHitbox(32, 32);
		}
	}
}