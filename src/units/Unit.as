package units 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import gameControlEngine.gameExtraClasses.RangeView;
	import gameControlEngine.gameExtraClasses.WatchingObject;
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
	public class Unit extends WatchingObject
	{
		protected var art : MovieClip = new MovieClip();
		
		
		protected var rangeView : RangeView = new RangeView();
		protected var destination : Point = new Point();
		protected var _waypointList : Array = [];
		
		//or enemy or destination
		protected var target : Vector2D = new Vector2D(); //for where to move (target vector to move to)
		public var targetUnit : Unit; //for target unit. Unit to fcus on when seen.
		
		//stats
		protected var _health : int;
		protected var attackDmg : int;
		protected var viewDistance : Number;
		protected var _speed : int;
		
		//movement
		protected var _moving : Boolean = true;
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
			setHitBox( -5, -10, 10, 10);
			addRangeView();
			
		}
		
		private function addRangeView():void 
		{
			addChild(rangeView);
			changeViewDistance(viewDistance);
		}
		
		protected function changeViewDistance(_viewDistance : int) :void {
			viewDistance = _viewDistance;
			rangeView.drawRangeView(viewDistance);
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
			setFocusOnTargetUnit();
			if (_waypointList.length > 0) {
				target.x = (_waypointList[0].position.x * TileSystem.globalTile.width) + TileSystem.globalTile.width / 2;
				target.y = (_waypointList[0].position.y * TileSystem.globalTile.height) + TileSystem.globalTile.height / 2;
			}
			if (targetUnit != null) {
				
				whenTargetInViewRange();
			}else {
				if (!_moving) {
					_moving = true;
				}
				calculateWaypoints(destination);
				trace("des : " + _waypointList);
			}
			if (_moving){
				movement();
				_position.add(_velocity);
				
				x = _position.x;
				y = _position.y;
			}
		}
		
		protected function whenTargetInViewRange():void 
		{
			
		}
		override public function removeTarget(targetObj:GameObject):void 
		{
			super.removeTarget(targetObj);
			_waypointList = [];
		}
		private function setFocusOnTargetUnit():void 
		{
			if(targetUnit != targetObjects[0]){
				targetUnit = targetObjects[0]; //als er een target is dan stopt hij die er in anders is currentTarget null
				trace(targetUnit);
			}
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
			
			if (distanceToTarget <= _velocity.length * 1) {
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
			rangeView.setAlpha(0.4);
		}
		override public function exitInteraction():void 
		{
			super.exitInteraction();
			trace("Close unit info");
			rangeView.setAlpha(0);
		}
		
		public function get velocity():Vector2D 
		{
			return _velocity;
		}
		
		public function get moving():Boolean 
		{
			return _moving;
		}
	}
}