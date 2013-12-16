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
	public class Crosshair extends Entity
	{
		public var sprite:Spritemap;
		
		public function Crosshair(x:int, y:int)
		{
			this.x = x;
			this.y = y;
			
			this.sprite = new Spritemap(Resources.Crosshair, 16, 16);
			
			this.sprite.add("hover", [0], 0, false);
			this.sprite.add("selected", [2, 1], 4, true);
			this.sprite.play("hover");
			
			this.sprite.scale = 2;
			this.type = "crosshair";
			this.graphic = sprite;
			this.layer = -1;
			this.setHitbox(32, 32);
		}
	}
}