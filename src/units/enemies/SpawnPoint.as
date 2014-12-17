package units.enemies 
{
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	import units.enemies.groundUnits.EnemyClawRobot;
	import units.enemies.groundUnits.EnemyUnit;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class SpawnPoint
	{
		private var _wavesToSpawnList : Array = [[new EnemyClawRobot]]; //in deze array komt een set van arrays. elke array is een wave die gespawnd word.
		private var _position : Point = new Point();
		private var _world : DisplayObjectContainer;
		
		public function SpawnPoint(world : DisplayObjectContainer) 
		{
			_world = world;
		}
		
		public function spawnWave(waveInt : int) :void {
			for (var i : int = 0; i < _wavesToSpawnList[waveInt].length; i++) {
				var monster : EnemyUnit = _wavesToSpawnList[waveInt][i] as EnemyUnit;
				monster.x = _position.x;
				monster.y = _position.y;
				_world.addChild(monster);
			}
		}
		
		public function set wavesToSpawnList(value:Array):void 
		{
			_wavesToSpawnList = value;
		}
		
		public function set position(value:Point):void 
		{
			_position = value;
		}
	}
}