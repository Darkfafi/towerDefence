package units.alies 
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import gameControlEngine.GameObject;
	import media.SoundManager;
	import towers.Tower;
	import units.enemies.groundUnits.EnemyMeleeUnit;
	import units.MeleeUnit;
	import units.Unit;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class BuildUnit extends MeleeUnit //mag geen buildunit meer zijn.
	{
		protected const BUILD_ANIM : int = 3;
		
		protected var buildSpeed : int;
		protected var buildTimer : Timer;
		
		public var targetTower : Tower;
		
		public function BuildUnit() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			movAtDthAnimList = [new BuilderWalkAnim, new BuilderUnitAttackArt, new BuilderDeathAnim, new BuilderBuildAnim]; // <== placeholders
			buildSpeed = 1000;
			buildTimer = new Timer(buildSpeed);
		}
		
		override protected function setStats():void 
		{
			_health = 50;
			costUnit = 20;
			attackDmg = 0;
			viewDistance = 50;
			_speed = 3;
			super.setStats();
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.addEventListener(Tower.TOWER_BUILD, towerDone);
			SoundManager.playSound(SoundManager.I_CAN_BUILD_IT);
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
		override protected function unitDeath():void 
		{
			if(targetTower != null){
				targetTower.lostBuilder();
			}
			super.unitDeath();
		}
		override public function removeObject():void 
		{
			if(!removing){
				buildTimer.removeEventListener(TimerEvent.TIMER, buildStageTik);
				stage.removeEventListener(Tower.TOWER_BUILD, towerDone);
				super.removeObject();
			}
		}
	}
}