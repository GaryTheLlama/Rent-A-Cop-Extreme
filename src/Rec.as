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
	public class Rec extends Entity
	{
		public var sprite:Spritemap;
		
		public function Rec(x:int, y:int)
		{
			this.x = x;
			this.y = y;
			
			this.sprite = new Spritemap(Resources.Rec, 64, 32);
			
			this.sprite.add("blink", [0, 1], 1.5, true);
			this.sprite.play("blink");
			
			this.sprite.scale = 1;
			this.type = "rec";
			this.graphic = sprite;
			this.layer = -1;
			this.setHitbox(128, 32);
		}
	}
}