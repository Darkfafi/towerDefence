package levels 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import units.enemies.groundUnits.EnemyUnit;
	import units.enemies.SpawnPoint;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Level 
	{
		protected var _levelBackGround : MovieClip = new MovieClip();
		protected var _levelGrid : Array;
		protected var _spawnPoints : Array = [];
		
		private var _world : DisplayObjectContainer;
		
		public function Level() 
		{
			setLevelInfo();
		}
		public function setWorld(world : DisplayObjectContainer):void {
			_world = world;
			loopLevel();
			setSpawnInfo();
		}
		protected function setSpawnInfo():void 
		{
			
		}
		
		protected function setLevelInfo():void 
		{
			
		}
		
		protected function loopLevel():void 
		{
			var lYRows : int = _levelGrid.length;
			for (var i : int = 0; i < lYRows; i++) {
				
				var lXRows : int = _levelGrid[i].length;
				
				for (var j : int = 0; j < lXRows; j++) {
					
					if (_levelGrid[i][j] == 4) {
						var spawnPoint : SpawnPoint = new SpawnPoint(_world);
						spawnPoint.position = new Point(j * TileSystem.globalTile.width,i * TileSystem.globalTile.height);
						_spawnPoints.push(spawnPoint);
					}
				}
			}
		}
		
		public function spawnWave(waveInt : int):void {
			for (var i : int = 0; i < _spawnPoints.length; i++) {
				var spawnPoint : SpawnPoint = _spawnPoints[i] as SpawnPoint;
				spawnPoint.spawnWave(waveInt);
			}
		}
		
		public function get levelGrid():Array 
		{
			return _levelGrid;
		}
		
		public function get levelBackGround():MovieClip 
		{
			return _levelBackGround;
		}
		
		public function get spawnPoints():Array 
		{
			return _spawnPoints;
		}
		
		protected function giveEnemyArray(enemyType : Class,amount : int):Array {
			var enemiesList : Array = [];
			for (var i : int = 0; i < amount; i++) {
				var enemy : EnemyUnit = new enemyType() as EnemyUnit;
				enemiesList.push(enemy);
			}
			return enemiesList;
		}
	}
}