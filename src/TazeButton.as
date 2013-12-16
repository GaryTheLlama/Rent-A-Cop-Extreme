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
	public class TazeButton extends Entity
	{
		private var sprite:Spritemap;
		
		public function TazeButton(x:int, y:int)
		{
			sprite = new Spritemap(Resources.TazeButton);
			
			this.x = x;
			this.y = y;
			this.width = sprite.width;
			this.height = sprite.height;
			this.type = "taze_button";
			this.layer = 10;
			//this.setHitbox(48, 32, 0, 0);
			
			sprite.add("idle", [0], 1, false);
			sprite.play("idle", true);
			
			graphic = new Graphiclist(sprite);
			
			this.setHitboxTo(graphic);
		}
		
		override public function update():void
		{
			if (collidePoint(x, y, world.mouseX, world.mouseY))
            {
                if (Input.mouseReleased)
				{
					//world.remove(this);
				}
            }
		}
	}
}