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
	public class Player extends Entity
	{
		private var sprite:Spritemap;
		
		public var velocity:Point;
		public var acceleration:Point;
		public var terminalVelocity:Point;
		
		public const MaxSpeed:Number = 250;
		public const Friction:Number = 0.88;
		public const GravityStrength:Number = 0.45;
		public const JumpVelocity:Number = 12;
		
		public function Player(x:int, y:int) 
		{
			sprite = new Spritemap(Resources.Player, 32, 32);
			
			this.type = "player";
			
			this.x = x;
			this.y = y;
			
			this.velocity = new Point(0, 0);
			this.acceleration = new Point(15, 15);
			this.terminalVelocity = new Point(1, 1);
			
			this.graphic = sprite;
			this.layer = -1;
			this.setHitbox(32, 32, 0, 0);
		}
		
		override public function update():void
		{
			if (Input.check(Key.RIGHT))
			{
				this.velocity.x += this.acceleration.x;
			}
			
			if (Input.check(Key.LEFT))
			{
				this.velocity.x -= this.acceleration.x;
			}
			
			if (Input.check(Key.UP))
			{
				this.velocity.y -= this.acceleration.y;
			}
			
			if (Input.check(Key.DOWN))
			{
				this.velocity.y += this.acceleration.y;
			}
			
			// Apply friction.
			if (!Input.check(Key.LEFT) && !Input.check(Key.RIGHT) && !Input.check(Key.UP) && !Input.check(Key.DOWN))
			{
				this.velocity.x *= this.Friction;
				this.velocity.y *= this.Friction;
			}
			
			// Check max speed.
			if (Math.abs(this.velocity.x) > this.MaxSpeed)
			{
				this.velocity.x = FP.sign(this.velocity.x) * this.MaxSpeed;
			}
			
			if (Math.abs(this.velocity.y) > this.MaxSpeed)
			{
				this.velocity.y = FP.sign(this.velocity.y) * this.MaxSpeed;
			}
			
			this.x += this.velocity.x * FP.elapsed;
			this.y += this.velocity.y * FP.elapsed;
		}
	}
}