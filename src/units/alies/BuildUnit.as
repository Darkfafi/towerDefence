package units.alies 
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import gameControlEngine.GameObject;
	import towers.Tower;
	import units.enemies.groundUnits.EnemyMeleeUnit;
	import units.MeleeUnit;
	import units.Unit;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class BuildUnit extends MeleeUnit
	{
		protected const BUILD_ANIM : int = 3;
		
		protected var buildSpeed : int;
		protected var buildTimer : Timer;
		
		public var targetTower : Tower;
		
		public function BuildUnit() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			movAtDthAnimList = [new BuilderWalkAnim, new BuilderUnitAttackArt, new BuilderUnitDeathArt, new BuilderBuildAnim]; // <== placeholders
			buildSpeed = 1000;
			buildTimer = new Timer(buildSpeed);
			rangeView.setSeeAbleObjects([EnemyMeleeUnit]);
		}
		
		override protected function setStats():void 
		{
			_health = 50;
			attackDmg = 2;
			viewDistance = 50;
			_speed = 2;
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
					_moving = false;
					buildTower();
					switchAnim(BUILD_ANIM);
				}
			}
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
			stage.removeEventListener(Tower.TOWER_BUILD, towerDone);
			super.removeObject();
		}
	}
}