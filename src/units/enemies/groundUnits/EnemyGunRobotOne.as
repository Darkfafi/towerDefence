package units.enemies.groundUnits 
{
	import units.MeleeUnit;
	import units.RangeUnit;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class EnemyGunRobotOne extends EnemyRangeUnit 
	{
		
		public function EnemyGunRobotOne() 
		{
			super();
			movAtDthAnimList = [new GunRobot1WalkAnim, new GunRobot1AttackAnim, new GunRobot1DeathAnim];
			rangeView.setSeeAbleObjects([MeleeUnit,RangeUnit]);
		}
		override protected function setStats():void 
		{
			
			killGoldWorth = 10;
			_health = 60;
			attackDmg = 7;
			viewDistance = 100;
			_speed = 2;
			
			super.setStats();
		}
	}
}