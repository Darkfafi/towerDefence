package units.enemies.groundUnits 
{
	import units.MeleeUnit;
	import units.RangeUnit;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class SpearRobot extends EnemyMeleeUnit 
	{
		
		public function SpearRobot() 
		{
			movAtDthAnimList = [new SpearRobotWalkAnim, new SpearRobotAttackAnim, new SpearRobotDeathAnim, new BuilderUnitBuildingArt]; // <== placeholders
			rangeView.setSeeAbleObjects([MeleeUnit,RangeUnit]);
		}
		override protected function setStats():void 
		{
			killGoldWorth = 15;
			_health = 60;
			attackDmg = 7;
			viewDistance = 60;
			_speed = 2;
			super.setStats();
		}	
	}

}