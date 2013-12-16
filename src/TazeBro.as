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
	public class TazeBro extends Entity
	{
		private var target:Entity;
		private var speed:Number = 3.0;
		private var sprite:Spritemap;
		private var reachedDest:Boolean = false;
		private var taze:Taze;
		private var tazeTimer:int = 5;
		
		public function TazeBro(target:Entity)
		{
			this.sprite = new Spritemap(Resources.TazeBro, 16, 16);
			
			sprite.add("idle", [0], 0, false);
			sprite.add("walk", [0, 1], 8, true);
			sprite.add("happy", [2, 3], 4, true);
			sprite.play("idle");
			
			this.sprite.scale = 2;
			this.type = "dude";
			this.graphic = sprite;
			this.layer = -2;
			this.setHitbox(16, 32);
			this.setOrigin(-8);
			
			this.x = FP.choose(0, 962);		
			this.y = 176;
			
			this.target = target;
			
			taze = new Taze(this.x + 15, this.y);
			FP.world.add(taze);
			
			if (target.x < this.x)
			{
				sprite.flipped = true;
			}
			else
			{
				sprite.flipped = false;
			}
		}
		
		override public function update():void
		{
			sprite.play("walk");
			
			if (distanceToPoint(target.x, target.y) > 32)
			{
				moveTowards(target.x, target.y, speed);
			}
			else
			{
				Attack();
			}
		}
		
		public function Attack():void
		{
			sprite.play("happy");
			
			if (sprite.flipped)
			{
				taze.x = this.x - 24;
				taze.y = this.y;
				taze.visible = true;
			}
			else
			{
				taze.x = this.x + 24;
				taze.y = this.y;
				taze.visible = true;
			}
		}
	}
}