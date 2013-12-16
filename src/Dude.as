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
	public class Dude extends Entity
	{
		private var target:Point;
		private var speed:Number = 0.8;
		private var sprite:Spritemap;
		private var state:String = "Normal";
		private var reachedDest:Boolean = false;
		
		public var isBadDude:Boolean = false;
		public var crosshair:Crosshair;
		
		private var selected:Boolean = false;
		private var goGoGo:Boolean = false;
		
		private var dudeState:String;
		private var xTarget:int;
		private var admireTimer:int;
		private var tazeTimer:int = 150;
		
		public function Dude(isBadDude:Boolean)
		{
			this.sprite = new Spritemap(Resources.Dude01, 16, 16);
			
			sprite.add("idle", [0], 0, false);
			sprite.add("walk", [0, 1], FP.choose(2, 3, 4, 6), true); // 4
			//sprite.add("happy_walk", [2, 3], FP.choose(2, 3, 4, 6), true);
			sprite.add("shocked", [0, 2, 3], 6, true);
			sprite.add("admiring", [4], 0, false);
			sprite.play("idle");
			
			this.sprite.scale = 2;
			this.type = "dude";
			this.graphic = sprite;
			this.layer = -2;
			this.setHitbox(24, 32);
			this.setOrigin(-8);
			
			this.x = FP.rand(940);			
			this.y = FP.choose(176);
			
			target = new Point(Math.floor(Math.random() * 940 / 16) * 16, 176);
			crosshair = new Crosshair(this.x, this.y);
			
			if (isBadDude)
			{
				this.isBadDude = true;
			}
			
			this.dudeState = "picking";
			admireTimer = Math.random() * 6;
		}
		
		public function Avoid(x:int, y:int, speed:int):void
		{
			var newX = x - this.x;
			var newY = y - this.y;
			var norm = new Point(newX, newY);
			norm.normalize(speed)
			
			 x -= norm.x;
			 y -= norm.y;
		}
		
		override public function update():void
		{
			if (!goGoGo)
			{
				if ((Global.currentScreen == Global.badDudeCurrentScreen && isBadDude) && dudeState != "leaveScreen")
				{
					dudeState = "leavingScreen";
				}
				
				if (isBadDude)
				{
					trace(dudeState);
				}
				
				sprite.play("walk");
				var array:Array = new Array();
				
				if (dudeState == "leaveScreen")
				{
					if (Global.currentScreen == 1)
					{
						xTarget = FP.choose(340);
					}
					else if (Global.currentScreen == 2)
					{
						xTarget = FP.choose(280, 660);
					}
					else if (Global.currentScreen == 3)
					{
						xTarget = FP.choose(260, 340);
					}
					
					dudeState = "leavingScreen";
				}
				
				if (dudeState == "leavingScreen")
				{
					if (xTarget < this.x)
					{
						sprite.flipped = true;
					}
					else
					{
						sprite.flipped = false;
					}
					
					if (distanceToPoint(xTarget, target.y) > 2)
					{
						moveTowards(xTarget, 176, speed);
					}
					else
					{
						dudeState = "picking";
					}
				}
				
				if (dudeState == "picking")
				{
					world.getClass(FP.choose(Painting, Painting2, Painting3, Sculpture, Statue), array);
					xTarget = ((Entity)(FP.choose(array))).x + FP.choose(1, 3, 5, 10, 12, 15, 20);
					dudeState = "search";
				}
				
				if (dudeState == "search")
				{
					if (xTarget < this.x)
					{
						sprite.flipped = true;
					}
					else
					{
						sprite.flipped = false;
					}
					
					if (distanceToPoint(xTarget, target.y) > 2)
					{
						moveTowards(xTarget, 176, speed);
					}
					else
					{
						dudeState = "admire";
						
						if (!isBadDude)
						{
							admireTimer = FP.choose(150, 200, 300);
						}
						else
						{
							admireTimer = FP.choose(30);
						}
						
					}
				}
				
				if (dudeState == "admire")
				{
					if (!isBadDude)
					{
						sprite.play("admiring");
					}
					
					if (admireTimer > 0)
					{
						admireTimer -= 1 * FP.elapsed;
					}
					else
					{
						dudeState = "picking";
					}
				}
				
				if (this.isBadDude)
				{
					sprite.play("happy_walk");
				}
				
				if (this.isBadDude)
				{
					if (this.x > 0 && this.x < 320)
					{
						Global.badDudeCurrentScreen = 1;
					}
					else if (this.x > 321 && this.x < 640)
					{
						Global.badDudeCurrentScreen = 2;
					}
					else if (this.x > 641 && this.x < 960)
					{
						Global.badDudeCurrentScreen = 3;
					}
				}
				
				crosshair.x = this.x;
				crosshair.y = this.y;
				
				if (collidePoint(x, y, world.mouseX, world.mouseY))
				{
					if (!selected)
					{
						this.layer = -2;
						crosshair.sprite.play("hover");
						crosshair.layer = -2;
						FP.world.add(crosshair);
					}
					else
					{
						crosshair.sprite.play("selected");
					}
					
					if (Input.mouseReleased)
					{
						selected = true;
						crosshair.sprite.play("selected");
					}
				}
				else
				{
					if (!selected)
					{
						this.layer = -1;
						
						FP.world.remove(crosshair);
					}
					
					if (Input.mousePressed)
					{
						selected = false;
						FP.world.remove(crosshair);
					}
				}
			}
			
			if (selected && Input.pressed(Key.SPACE))
			{
				goGoGo = true;
				crosshair.visible = false;
				
				var t1:TazeBro = new TazeBro(this);
				var t2:TazeBro = new TazeBro(this);
				FP.world.add(t1);
				FP.world.add(t2);
				
				// TODO: Panic animation when they've been found out.
			}
			
			if (collide("taze", this.x, this.y))
			{
				sprite.play("shocked");
				
				trace(tazeTimer);
				
				if (tazeTimer > 0)
				{
					tazeTimer -= 1 * FP.elapsed;
				}
				else if (tazeTimer <= 0)
				{
					if (isBadDude)
					{
						FP.world = new WinWorld();
					}
					else
					{
						FP.world = new LoseWorld();
					}
				}
			}
		}
	}
}