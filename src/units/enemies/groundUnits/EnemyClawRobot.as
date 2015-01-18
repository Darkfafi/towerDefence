package units.enemies.groundUnits 
{
	import units.MeleeUnit;
	import units.RangeUnit;
	import units.Unit;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class EnemyClawRobot extends EnemyMeleeUnit
	{
		
		public function EnemyClawRobot() 
		{
			movAtDthAnimList = [new ClawEnemyWalkAnim, new ClawEnemyAttackAnim, new ClawEnemyDeathAnim]; // <== placeholders
			rangeView.setSeeAbleObjects([MeleeUnit,RangeUnit]);
		}
		override protected function setStats():void 
		{
			killGoldWorth = 10;
			_health = 50;
			attackDmg = 5;
			viewDistance = 50;
			_speed = 3;
			super.setStats();
		}	
	}
}