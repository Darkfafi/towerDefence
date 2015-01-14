package levels.levelList 
{
	import levels.Level;
	import units.enemies.groundUnits.EnemyClawRobot;
	import units.enemies.groundUnits.SpearRobot;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Level1 extends Level 
	{
		
		public function Level1() 
		{
			super();
		}
		override protected function setLevelInfo():void 
		{
			_levelBackGround = new LevelOneBgArt(); //als map niet goed is komt er lag
			_timeTillLevelStarts = 10000;
			_timeUntilNextWave = 5000;
			levelStartGold = 240;
			
			_levelGrid = [
				[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
				[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
				[0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0],
				[0, 0, 0, 0, 0, 0, 1, 2, 2, 2, 2, 1],
				[0, 0, 0, 0, 0, 1, 2, 2, 1, 1, 2, 1],
				[1, 1, 1, 1, 1, 2, 2, 1, 0, 1, 2, 4],
				[3, 2, 2, 2, 2, 2, 1, 0, 0, 0, 1, 1],
				[1, 1, 1, 1, 1, 2, 2, 1, 1, 1, 2, 4],
				[0, 0, 0, 0, 0, 1, 2, 2, 2, 2, 2, 1],
				[0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0],
				[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
				[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
			];
		}
		override protected function setSpawnInfo():void 
		{
			_world.addChild(_levelBackGround);
			
			_spawnPoints[0].wavesToSpawnList = [
				giveEnemyArray(EnemyClawRobot, 3),
				giveEnemyArray(EnemyClawRobot, 5),
				giveEnemyArray(EnemyClawRobot, 4),
				giveEnemyArray(EnemyClawRobot, 5),
				giveEnemyArray(SpearRobot, 7)
			];
			
			_spawnPoints[1].wavesToSpawnList = [
				null,
				null,
				giveEnemyArray(SpearRobot, 3),
				giveEnemyArray(SpearRobot, 5),
				giveEnemyArray(EnemyClawRobot, 6)
			];
		}
		
	}

}