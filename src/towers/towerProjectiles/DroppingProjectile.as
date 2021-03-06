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
		private var targetUnitVelocity : Vector2D;
		private var startPos : Point;
		private var time : Number = 0;
		private var shootingPower : Number;
		private var totalsteps : Number;
		
		private var explosionRadius : int;
		
		//private var allExplosions : Array = [];
		
		public function DroppingProjectile(bulletDamage:int, bulletSpeed:int, bulletTarget:Unit,shootPower : Number = 50,explRadius : int = 40) 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			super(bulletDamage, bulletSpeed, bulletTarget);
			
			explosionRadius = explRadius;
			
			if(target != null){
				targetPosition = new Vector2D(bulletTarget.x, bulletTarget.y);
				
				targetUnitVelocity = bulletTarget.velocity.cloneVector();
				
				var targetUnitMoving : int = bulletTarget.moving == true ? 1 : 0;
				
				targetUnitVelocity.multiply(targetUnitMoving);
				
				shootingPower = shootPower;
			}
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
			var currentPos : Point = MathFunctions.cubic(startPos, new Point(startPos.x, startPos.y - shootingPower * 2), 
			new Point(targetPosition.x + targetUnitVelocity.x * totalsteps, targetPosition.y - shootingPower + targetUnitVelocity.y * totalsteps), 
			new Point(targetPosition.x + targetUnitVelocity.x * (totalsteps/ 3), targetPosition.y + targetUnitVelocity.y * (totalsteps/3)), time);
			_position = new Vector2D(currentPos.x, currentPos.y);
			time += 1 / totalsteps;
		}
		override public function update():void 
		{
			super.update();
			if(time < 1){
				calculateCurve();
			}else {
				explode();
			}
			
			_position.add(_velocity);
			
			x = _position.x;
			y = _position.y;
		}
		
		private function explode():void 
		{
			//target.takeDamage(damage); // test. Moet met explosie alles wat de explosie raakt via hit array ofzo
			var explosion : Explosion = new Explosion(CanonBallExpl1Anim, explosionRadius, damage);
			
			explosion.x = x;
			explosion.y = y;
			
			parent.addChild(explosion);
			removeObject();
		}
		
		
	}

}