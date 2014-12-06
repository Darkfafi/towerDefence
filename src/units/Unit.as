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
		protected var target : Vector2D = new Vector2D();
		
		protected var _health : int;
		
		protected var _position : Vector2D = new Vector2D();
		protected var _velocity : Vector2D = new Vector2D();
		protected var _speed : int;
		
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
			
			drawUnit();
			calculateWaypoints();
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
			var realPath : Vector2D = new Vector2D(destination.x, destination.y);
			
			for (var i : int = 0; i < realPath.length; i += 5) {
				var tile : Tile = new Tile();
				var waypoint : Vector2D = realPath.cloneVector();
				waypoint.normalize();
				waypoint.multiply(i);
				_waypointList.push(waypoint);
			}
		}
		
		override public function update():void 
		{
			super.update();
			if (_waypointList[0] != null) {
				target = _waypointList[0] as Vector2D;
				trace(target);
			}
			movement();
		}
		
		private function movement():void 
		{
			
		}
	}

}