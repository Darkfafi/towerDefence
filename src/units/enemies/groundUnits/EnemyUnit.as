package units.enemies.groundUnits 
{
	import flash.events.Event;
	import flash.geom.Point;
	import gameControlEngine.GameObject;
	import levels.TileSystem;
	import playerControl.PlayerBase;
	import units.Unit;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class EnemyUnit extends Unit
	{	
		private var playerBase : PlayerBase;
		
		private var _typeList : Array = []; // hier komt of het flying is etc etc. will be checked wit function.
		
		public function EnemyUnit() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			playerBase = TileSystem.getPlayerBase();
			destination = new Point(playerBase.x, playerBase.y);
			calculateWaypoints(destination);
		}
		
		override protected function lastWaypointReached():void 
		{
			super.lastWaypointReached();
			if (destination.x - this.x < 2 && destination.y - this.y < 2) {
				playerBase.loseLife(1);
				removeObject();
			}
		}
	}
}