package towers.towerProjectiles 
{
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import gameControlEngine.GameObject;
	import utils.MathFunctions;
	import utils.Vector2D;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class DroppingProjectile extends Projectile 
	{
		private var startPos : Point;
		private var time : Number = 0;
		private var waypointList : Array = [];
		
		public function DroppingProjectile(bulletDamage:int, bulletSpeed:int, bulletTarget:GameObject) 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			
			super(bulletDamage, bulletSpeed, bulletTarget);
			targetPosition = new Vector2D(bulletTarget.x, bulletTarget.y);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			startPos = new Point(x, y);
			trace(startPos);
			calculateCurve();
		}
		
		private function calculateCurve():void 
		{
			while (time < 1) {
				var currentPos : Point = MathFunctions.cubic(startPos, new Point(startPos.x, startPos.y - 50), new Point(targetPosition.x, targetPosition.y - 50), new Point(targetPosition.x, targetPosition.y), time);
				time += 0.2;
				waypointList.push(currentPos);
			}
		}
		override public function update():void 
		{
			super.update();
			if (waypointList.length > 0) {
				movement();
			}else {
				removeObject();
			}
			
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
			
			var currentTarget : Vector2D = new Vector2D(waypointList[0].x, waypointList[0].y);
			
			var desiredStep : Vector2D = currentTarget.subtract(_position);
			var distanceToTarget : Number =	desiredStep.length;
			
			desiredStep.normalize();
			
			var desiredVelocity:Vector2D = desiredStep.multiply(speed);
			
			var steeringForce:Vector2D = desiredVelocity.subtract(_velocity);

			steeringForce.divide(2);
			
			_velocity.add(steeringForce);
			
			
			if (distanceToTarget <= _velocity.length * 1) {
				closeToTarget();
			}
			
		}
		
		private function closeToTarget():void 
		{
			waypointList.splice(0, 1);
		}
		
	}

}