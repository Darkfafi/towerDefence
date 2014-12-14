package towers.towerProjectiles 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import gameControlEngine.GameObject;
	import utils.Vector2D;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class DroppingProjectile extends Projectile 
	{
		
		
		public function DroppingProjectile(bulletDamage:int, bulletSpeed:int, bulletTarget:GameObject) 
		{
			super(bulletDamage, bulletSpeed, bulletTarget);
			targetPosition = new Vector2D(bulletTarget.x, bulletTarget.y);
		}
		override public function update():void 
		{
			super.update();
			
			_position.add(_velocity);
			
			x = _position.x;
			y = _position.y;
		}
		
		override protected function movement():void 
		{
			super.movement();
			
			if (!targetPosition)
			{
				return; 
			}
			
			var currentTarget : Vector2D = targetPosition.cloneVector();
			
			var desiredStep : Vector2D = currentTarget.subtract(_position);
			var distanceToTarget : Number =	desiredStep.length;
			
			desiredStep.normalize();
			
			var desiredVelocity:Vector2D = desiredStep.multiply(speed);
			
			var steeringForce:Vector2D = desiredVelocity.subtract(_velocity);

			steeringForce.divide(2);
			
			_velocity.add(steeringForce);
			
		}
		
	}

}