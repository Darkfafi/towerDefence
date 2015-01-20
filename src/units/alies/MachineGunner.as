package units.alies 
{
	import flash.events.Event;
	import media.SoundManager;
	import units.enemies.groundUnits.EnemyUnit;
	import units.RangeUnit;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class MachineGunner extends RangeUnit 
	{	
		
		
		public function MachineGunner() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, init);
			movAtDthAnimList = [new MachineGunUnitWalkAnim, new MachineGunUnitShootAnim, new MachineGunUnitDeathAnim, new MachineGunUnitIdleAnim]; // <== placeholders
			rangeView.setSeeAbleObjects([EnemyUnit]);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			SoundManager.playSound(SoundManager.UTOPIA_MY_ASS);
		}
		override protected function setStats():void 
		{
			_health = 50;
			costUnit = 20;
			attackDmg = 5;
			viewDistance = 120;
			_speed = 3;
			
			super.setStats();
		}
	}
}