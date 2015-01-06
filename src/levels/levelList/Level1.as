package levels.levelList 
{
	import levels.Level;
	import units.enemies.groundUnits.EnemyClawRobot;
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
			_levelBackGround = new LevelOneBgArt();
			_levelGrid = [
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
				[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
				[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
			];
		}
		override protected function setSpawnInfo():void 
		{
			_world.addChild(_levelBackGround);
			
			_spawnPoints[0].wavesToSpawnList = [
				giveEnemyArray(EnemyClawRobot, 5),
				giveEnemyArray(EnemyClawRobot, 10)
			];
			
			_spawnPoints[1].wavesToSpawnList = [
				giveEnemyArray(EnemyClawRobot, 2),
				giveEnemyArray(EnemyClawRobot, 3)
			];
		}
		
	}

}