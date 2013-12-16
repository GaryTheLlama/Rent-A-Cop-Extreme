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
	public class Painting2 extends Entity
	{
		public var sprite:Spritemap;
		
		public function Painting2(x:int, y:int)
		{
			this.x = x;
			this.y = y;
			
			this.sprite = new Spritemap(Resources.Painting02, 52, 26);
			this.sprite.scale = 1.5;
			this.type = "painting";
			this.graphic = sprite;
			this.layer = -1;
			this.setHitbox(32, 32);
		}
	}
}