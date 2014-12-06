package units 
{
	import flash.events.Event;
	import flash.geom.Point;
	import gameControlEngine.GameObject;
	import gameControlEngine.Tags;
	import levels.TileSystem;
	import utils.Vector2D;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Unit extends GameObject
	{
		protected var destination : Vector2D = new Vector2D();
		protected var _waypointList : Array = [];
		
		//or enemy or destination
		protected var target : Vector2D = new Vector2D();
		
		protected var _health : int;
		
		protected var _position : Vector2D = new Vector2D();
		protected var _velocity : Vector2D = new Vector2D();
		protected var _speed : int = 2;
		
		public function Unit() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addTag(Tags.UPDATE_TAG);
			
			_position.x = this.x;
			_position.y = this.y;
			calculateWaypoints();
			drawUnit();
		}
		
		private function drawUnit():void 
		{
			graphics.beginFill(0x000000, 1);
			graphics.drawCircle(0, 0, 3);
			graphics.endFill();
		}
		
		public function setDestination(xPos : int, yPos : int) :void {
			destination.x = xPos;
			destination.y = yPos;
		}
		
		private function calculateWaypoints():void 
		{
			//zo lang het verschil tussen de waypoint en target groter is dan 4. Dan blijf waypoints maken van unit naar target.
			var stepNextWaypoint : int = 10;
			var waypoint : Vector2D = new Vector2D(x, y);
			var calculatedRoute : Vector2D;
			while (waypoint.x >= destination.x) {
				calculatedRoute = new Vector2D(destination.x - waypoint.x, destination.y - waypoint.y);
				calculatedRoute.normalize();
				calculatedRoute.multiply(stepNextWaypoint);
				waypoint.add(calculatedRoute);
				
				_waypointList.push(waypoint);
				
				var tile : Tile = new Tile();
				tile.negativeTile();
				tile.x = waypoint.x;
				tile.y = waypoint.y;
				tile.scaleX = 0.1;
				tile.scaleY = 0.1;
				stage.addChild(tile);
			}
		}
		
		override public function update():void 
		{
			super.update();
			target = destination;
			movement();
			//---------------Test------------------
			if (TileSystem.hitTileInt(new Vector2D(_position.x + _velocity.x * 10, _position.y)) == 2){
				_position.x += _velocity.x;
			}else if (TileSystem.hitTileInt(new Vector2D(_position.x, _position.y + _velocity.y)) == 2) {
				_position.y += _velocity.y * 4;
			}
			//------------------------------------
			x = _position.x;
			y = _position.y;
		}
		
		private function movement():void 
		{
			if (!target)
			{
				return; 
			}
			
			var currentTarget : Vector2D = target.cloneVector();
			
			var desiredStep : Vector2D = currentTarget.subtract(_position);
			var distanceToTarget : Number =	desiredStep.length;
			
			desiredStep.normalize();
			
			var desiredVelocity:Vector2D = desiredStep.multiply(_speed);
			
			var steeringForce:Vector2D = desiredVelocity.subtract(_velocity);

			steeringForce.divide(2);
			
			_velocity.add(steeringForce);
			
			rotation = _velocity.angle * 180 / Math.PI;
			
			if (distanceToTarget <= _velocity.length * 2) {
				closeToTarget();
			}
		}
		
		protected function closeToTarget():void 
		{
			
		}
	}

}