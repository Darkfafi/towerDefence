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
			var stepNextWaypoint : Point = new Point(40,30);
			var waypoint : Vector2D = new Vector2D(x, y);
			var calculatedRoute : Vector2D;
			var outOfBoundX : Boolean = false;
			var outOfBoundY : Boolean = false;
			while (waypoint.length - destination.length > 3){
				calculatedRoute = new Vector2D(destination.x - waypoint.x, destination.y - waypoint.y);
				calculatedRoute.normalize();
				var dir : Point = new Point();
				if (calculatedRoute.x < 0) {
					dir.x = -1;
				}else {
					dir.x = 1;
				}
				if (calculatedRoute.y < 0) {
					dir.y = -1;
				}else {
					dir.y = 1;
				}
				if (TileSystem.hitTileInt(new Vector2D(waypoint.x + dir.x * stepNextWaypoint.x, waypoint.y)) == 2 && !outOfBoundX) {
					waypoint.x += stepNextWaypoint.x * dir.x;
					outOfBoundY = false;
				}else if (TileSystem.hitTileInt(new Vector2D(waypoint.x, waypoint.y + dir.y * stepNextWaypoint.y)) == 2 && !outOfBoundY) {
					waypoint.y += stepNextWaypoint.y * dir.y;
					outOfBoundX = false
				}else if (waypoint.x - calculatedRoute.x < 1 && TileSystem.hitTileInt(new Vector2D(waypoint.x - dir.x * stepNextWaypoint.x, waypoint.y)) == 2) {
					waypoint.x -= stepNextWaypoint.x * dir.x;
					outOfBoundX = true;
				}else if (waypoint.y - calculatedRoute.y < 1 && TileSystem.hitTileInt(new Vector2D(waypoint.x, waypoint.y - dir.y * stepNextWaypoint.y)) == 2) {
					waypoint.y -= stepNextWaypoint.y * dir.y;
					outOfBoundY = true;
				}
				var newWaypoint : Vector2D = waypoint.cloneVector();
				
				_waypointList.push(newWaypoint);
				
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
			target = _waypointList[0];
			movement();
			_position.add(_velocity);
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
			_waypointList.splice(0, 1);
			if (_waypointList.length == 0) {
				removeObject(); // <== test;
			}
		}
	}

}