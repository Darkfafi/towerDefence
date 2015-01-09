package units.enemies.groundUnits 
{
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class EnemyClawRobot extends EnemyUnit
	{
		
		public function EnemyClawRobot() 
		{
			movAtDthAnimList = [new BuilderMoveUnitArt, new BuilderUnitAttackArt, new BuilderUnitDeathArt, new BuilderUnitBuildingArt]; // <== placeholders
		}
		override protected function setStats():void 
		{
			killGoldWorth = 10;
			_health = 50;
			attackDmg = 5;
			viewDistance = 50;
			_speed = 3;
		}	
	}
}