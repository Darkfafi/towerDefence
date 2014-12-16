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
		
		public function BuildUnit() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			buildSpeed = 1000;
			buildTimer = new Timer(buildSpeed);
		}
		
		override protected function setStats():void 
		{
			_health = 50;
			attackDmg = 2;
			viewDistance = 50;
			_speed = 2;
			rangeView.setSeeAbleObjects([Unit]);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.addEventListener(Tower.TOWER_BUILD, towerDone);
		}
		public function setTowerTarget(towerToBuild : Tower) :void {
			targetTower = towerToBuild;
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
		}
		override protected function drawUnit():void 
		{
			art.graphics.beginFill(0x0000FF, 1);
			art.graphics.drawRect(-10, -30, 20,30);
			art.graphics.endFill();
			addChild(art);
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