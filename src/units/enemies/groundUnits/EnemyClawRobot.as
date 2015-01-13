package units.enemies.groundUnits 
{
	import units.MeleeUnit;
	import units.Unit;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class EnemyClawRobot extends EnemyMeleeUnit
	{
		
		public function EnemyClawRobot() 
		{
			movAtDthAnimList = [new ClawEnemyWalkAnim, new BuilderUnitAttackArt, new ClawEnemyDeathAnim, new BuilderUnitBuildingArt]; // <== placeholders
			rangeView.setSeeAbleObjects([MeleeUnit]);
		}
		override protected function setStats():void 
		{
			killGoldWorth = 10;
			_health = 50;
			attackDmg = 10;
			viewDistance = 50;
			_speed = 3;
		}	
	}
}