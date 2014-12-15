package towers.towerProjectiles 
{
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import gameControlEngine.GameObject;
	import units.Unit;
	import utils.MathFunctions;
	import utils.Vector2D;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class DroppingProjectile extends Projectile 
	{
		private var targetUnit : Unit;
		private var startPos : Point;
		private var time : Number = 0;
		private var shootingPower : Number;
		private var totalsteps : Number;
		
		public function DroppingProjectile(bulletDamage:int, bulletSpeed:int, bulletTarget:Unit,shootPower : Number = 50) 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			
			super(bulletDamage, bulletSpeed, bulletTarget);
			targetPosition = new Vector2D(bulletTarget.x, bulletTarget.y);
			targetUnit = bulletTarget;
			shootingPower = shootPower;
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			startPos = new Point(x, y);
			
			var dif : Vector2D = new Vector2D(x - targetPosition.x, y - targetPosition.y + shootingPower);
			totalsteps = (dif.length * 2) / speed;
			
		}
		
		private function calculateCurve():void 
		{
			var currentPos : Point = MathFunctions.cubic(startPos, new Point(startPos.x, startPos.y - shootingPower), new Point(targetPosition.x + targetUnit.velocity.x * totalsteps, targetPosition.y - shootingPower + targetUnit.velocity.y * totalsteps), new Point(targetPosition.x + targetUnit.velocity.x * totalsteps, targetPosition.y + targetUnit.velocity.y * totalsteps), time);
			_position = new Vector2D(currentPos.x, currentPos.y);
			time += 1 / totalsteps;
		}
		override public function update():void 
		{
			super.update();
			if(time < 1){
				calculateCurve();
			}else {
				removeObject();
			}
			
			_position.add(_velocity);
			
			x = _position.x;
			y = _position.y;
		}
		
		
	}

}