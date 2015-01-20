package units.alies 
{
	import flash.events.Event;
	import media.SoundManager;
	import units.enemies.groundUnits.EnemyUnit;
	import units.MeleeUnit;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class KnifeUnit extends MeleeUnit 
	{
		
		public function KnifeUnit() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, init);
			movAtDthAnimList = [new KnifeUnitWalkAnim, new KnifeUnitAttackAnim, new KnifeUnitDeathAnim, new KnifeUnitIdleAnim];
			rangeView.setSeeAbleObjects([EnemyUnit]);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			SoundManager.playSound(SoundManager.NAHAHAHHAAHA);
		}
		override protected function setStats():void 
		{
			costUnit = 30;
			_health = 75;
			attackDmg = 10;
			viewDistance = 50;
			_speed = 2;
			super.setStats();
		}	
	}

}