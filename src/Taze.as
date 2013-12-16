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
	public class Taze extends Entity
	{
		public var sprite:Spritemap;
		
		public function Taze(x:int, y:int)
		{
			this.x = x;
			this.y = y;
			
			this.sprite = new Spritemap(Resources.Taze, 16, 16);
			
			this.sprite.add("taze", [0, 1, 2], 4, true);
			this.sprite.play("taze");
			
			this.sprite.scale = 2;
			this.type = "taze";
			this.graphic = sprite;
			this.layer = -150;
			this.setHitbox(32, 32);
			this.visible = false;
		}
	}
}