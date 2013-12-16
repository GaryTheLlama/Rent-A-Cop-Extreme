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
	public class DiamondDisplay extends Entity
	{
		public var sprite:Spritemap;
		
		public function DiamondDisplay(x:int, y:int)
		{
			this.x = x;
			this.y = y;
			
			this.sprite = new Spritemap(Resources.DiamondDisplay, 16, 32);
			
			this.sprite.add("idle", [0], 1, false);
			this.sprite.play("idle");
			
			this.sprite.scale = 1;
			this.type = "display";
			this.graphic = sprite;
			this.layer = -4;
			this.setHitbox(16, 32);
		}
	}
}