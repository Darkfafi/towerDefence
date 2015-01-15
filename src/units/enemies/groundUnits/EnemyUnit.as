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
		protected var killGoldWorth : int;
		
		protected var atBaseDamage : int = 1;
		
		private var playerBase : PlayerBase;
		
		private var _typeList : Array = []; // hier komt of het flying is etc etc. will be checked wit function.
		
		public function EnemyUnit() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			deployUnit = false;
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			playerBase = TileSystem.getPlayerBase();
			destination = new Point(playerBase.x + playerBase.width / 2, playerBase.y + playerBase.height/ 2);
			calculateWaypoints(destination);
		}
		override protected function movement():void 
		{
			super.movement();
		}
		override protected function unitDeath():void 
		{
			if(!removing){
				playerBase.addGoldToPlayer(killGoldWorth);
				super.unitDeath();
			}
		}
		override protected function turnArt(dir:int):void 
		{
			super.turnArt(dir * -1);
		}
		override protected function lastWaypointReached():void 
		{
			super.lastWaypointReached();
			if (this.x - destination.x < 1 && this.y - destination.y < 1) {
				playerBase.loseLife(atBaseDamage);
				removeObject();
			}
		}
	}
}