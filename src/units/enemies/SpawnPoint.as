package units.enemies 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import units.enemies.groundUnits.EnemyClawRobot;
	import units.enemies.groundUnits.EnemyUnit;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class SpawnPoint
	{
		private var spawnTimer : Timer;
		private var currentWave : int;
		private var _wavesToSpawnList : Array = [[new EnemyClawRobot,new EnemyClawRobot],[new EnemyClawRobot,new EnemyClawRobot, new EnemyClawRobot]]; //in deze array komt een set van arrays. elke array is een wave die gespawnd word.
		
		private var _position : Point = new Point();
		private var _world : DisplayObjectContainer;
		
		public function SpawnPoint(world : DisplayObjectContainer) 
		{
			_world = world;
		}
		
		public function spawnWave(waveInt : int, timeTillNextEnemy : int = 1000) :void {
			
			currentWave = waveInt - 1;
			spawnTimer = new Timer(timeTillNextEnemy, _wavesToSpawnList[currentWave].length);
			
			spawnTimer.addEventListener(TimerEvent.TIMER, spawnEnemy);
			spawnTimer.addEventListener(TimerEvent.TIMER_COMPLETE, doneWaveSpawn);
			
			spawnTimer.start();
		}
		
		private function spawnEnemy(t:TimerEvent):void {
			var timerE : Timer = t.target as Timer;
			var monster : EnemyUnit = _wavesToSpawnList[currentWave][timerE.currentCount - 1] as EnemyUnit;
			monster.x = _position.x;
			monster.y = _position.y;
			_world.addChild(monster);
		}
		
		private function doneWaveSpawn(t:TimerEvent):void 
		{
			spawnTimer.reset();
			spawnTimer.stop();
			
			trace("DONE WITH WAVE " + (currentWave + 1))
			
			spawnTimer.removeEventListener(TimerEvent.TIMER, spawnEnemy);
			spawnTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, doneWaveSpawn);
		}
		
		public function set wavesToSpawnList(arrayWithWaves:Array):void 
		{
			_wavesToSpawnList = arrayWithWaves;
		}
		public function set position(value:Point):void 
		{
			_position = value;
		}
	}
}