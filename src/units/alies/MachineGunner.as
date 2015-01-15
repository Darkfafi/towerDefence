package units.alies 
{
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
			
			movAtDthAnimList = [new MachineGunUnitWalkAnim, new MachineGunUnitShootAnim, new MachineGunUnitDeathAnim, new MachineGunUnitIdleAnim]; // <== placeholders
			rangeView.setSeeAbleObjects([EnemyUnit]);
		}
		override protected function setStats():void 
		{
			_health = 50;
			costUnit = 50;
			attackDmg = 15;
			viewDistance = 120;
			_speed = 3;
			
			super.setStats();
		}
	}
}