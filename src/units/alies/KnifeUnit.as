package units.alies 
{
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
			movAtDthAnimList = [new KnifeUnitWalkAnim, new KnifeUnitAttackAnim, new KnifeUnitDeathAnim, new KnifeUnitIdleAnim];
			rangeView.setSeeAbleObjects([EnemyUnit]);
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