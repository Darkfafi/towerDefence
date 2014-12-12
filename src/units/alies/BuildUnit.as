package units.alies 
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import gameControlEngine.GameObject;
	import towers.Tower;
	import units.Unit;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class BuildUnit extends Unit
	{
		protected var buildSpeed : int;
		protected var buildTimer : Timer;
		
		public var targetTower : Tower;
		
		public function BuildUnit(towerToBuild : Tower) 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			targetTower = towerToBuild;
			distanceToClose = 40
			buildSpeed = 1000;
			buildTimer = new Timer(buildSpeed);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.addEventListener(Tower.TOWER_BUILD, towerDone);
		}
		
		private function towerDone(e:Event):void 
		{
			if(e.target == targetTower){
				removeObject();
			}
		}
		override public function onCollisionEnter(other:GameObject):void 
		{
			super.onCollisionEnter(other);
			if(other is Tower){
				var tower : Tower = other as Tower;
				if(tower == targetTower){
					_speed = 0;
					buildTower();
				}
			}
			//removeObject();
			//if done building then 
			//if died then remove target tower with removeObject.
		}
		
		public function buildTower():void {
			buildTimer.addEventListener(TimerEvent.TIMER, buildStageTik);
			buildTimer.start();
		}
		
		private function buildStageTik(t:TimerEvent):void 
		{
			targetTower.towerBuildUp();
		}
		
		override public function removeObject():void 
		{
			buildTimer.removeEventListener(TimerEvent.TIMER, buildStageTik);
			super.removeObject();
		}
	}

}