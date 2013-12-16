package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.utils.Input;
	
	/**
	 * ...
	 * @author Gary the Llama
	 */
	public class GoButton extends Entity
	{
		private var sprite:Spritemap;
		
		public function GoButton(x:int, y:int)
		{
			sprite = new Spritemap(Resources.GoButton);
			
			this.x = x;
			this.y = y;
			this.width = sprite.width;
			this.height = sprite.height;
			this.type = "go_button";
			this.layer = 10;
			
			sprite.add("idle", [0], 1, false);
			sprite.play("idle", true);
			
			graphic = new Graphiclist(sprite);
			
			this.setHitboxTo(graphic);
		}
	}
}