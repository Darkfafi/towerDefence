package units.enemies.groundUnits 
{
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class SpearRobot extends EnemyMeleeUnit 
	{
		
		public function SpearRobot() 
		{
			movAtDthAnimList = [new SpearRobotWalkAnim, new BuilderUnitAttackArt, new SpearRobotDeathAnim, new BuilderUnitBuildingArt]; // <== placeholders
		}
		override protected function setStats():void 
		{
			killGoldWorth = 5;
			_health = 25;
			attackDmg = 3;
			viewDistance = 60;
			_speed = 4.5;
		}	
	}

}