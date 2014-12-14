package units 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import gameControlEngine.GameObject;
	import gameControlEngine.Tags;
	import levels.Levels;
	import levels.TileSystem;
	import pathfinderAStar.grid.AStar;
	import utils.Vector2D;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Unit extends GameObject
	{
		protected var art : MovieClip = new MovieClip();
		
		
		protected var distanceToClose : int = 2;
		protected var destination : Point = new Point();
		protected var _waypointList : Array = [];
		
		//or enemy or destination
		protected var target : Vector2D = new Vector2D();
		
		//stats
		protected var _health : int;
		protected var attackDmg : int;
		protected var viewDistance : Number;
		protected var _speed : int;
		
		//movement
		protected var _position : Vector2D = new Vector2D();
		protected var _velocity : Vector2D = new Vector2D();
		
		public function Unit() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			addTag(Tags.UPDATE_TAG);
			addTag(Tags.INTERACTIVE_TAG);
			addTag(Tags.COLLIDER_TAG);
			addTag(Tags.POSITION_ON_Y_TAG);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			setStats();
			_position.x = this.x;
			_position.y = this.y;
			setHitBox(-5, -10, 10, 10);
		}
		
		protected function setStats():void 
		{
			
		}
		override protected function drawHitBoxObjectArt():void 
		{
			super.drawHitBoxObjectArt();
			drawUnit();
		}
		protected function drawUnit():void 
		{
			
		}
		
		public function setDestination(xPos : int, yPos : int) :void {
			destination.x = xPos;
			destination.y = yPos;
		}
		
		public function calculateWaypoints(dest : Point):void 
		{
			var start : Point = new Point(Math.floor(x / TileSystem.globalTile.width), Math.floor(y / TileSystem.globalTile.height));
			var fin : Point = new Point(Math.floor(dest.x / TileSystem.globalTile.width), Math.floor(dest.y / TileSystem.globalTile.height));
			_waypointList = AStar.search(TileSystem.grid, start, fin);
		}
		
		override public function update():void 
		{
			super.update();
			if(_waypointList.length > 0){
				target.x = (_waypointList[0].position.x * TileSystem.globalTile.width) + TileSystem.globalTile.width / 2;
				target.y = (_waypointList[0].position.y * TileSystem.globalTile.height) + TileSystem.globalTile.height / 2;
			}
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
			
			if (distanceToTarget <= _velocity.length * distanceToClose) {
				closeToTarget();
			}
		}
		
		protected function closeToTarget():void 
		{
			_waypointList.splice(0, 1);
			if (_waypointList.length == 0) {
				lastWaypointReached();
			}
		}
		
		protected function lastWaypointReached():void 
		{
			
		}
		override public function onCollisionEnter(other:GameObject):void 
		{
			if (other.checkTag(Tags.RANGE_COLLIDER_TAG) == false) {
				super.onCollisionEnter(other);
			}
		}
		override public function onInteraction():void 
		{
			super.onInteraction();
			trace("See unit info");
		}
	}

}