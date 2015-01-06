package units.enemies 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
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
		public var wavesToSpawnList : Array = []; //in deze array komt een set van arrays. elke array is een wave die gespawnd word.
		
		private var _position : Point = new Point();
		private var _world : DisplayObjectContainer;
		
		public function SpawnPoint(world : DisplayObjectContainer) 
		{
			_world = world;
		}
		
		public function spawnWave(waveInt : int, timeTillNextEnemy : int = 1000) :void {
			
			currentWave = waveInt - 1;
			if(wavesToSpawnList.length > 0){
				spawnTimer = new Timer(timeTillNextEnemy, wavesToSpawnList[currentWave].length);
				
				spawnTimer.addEventListener(TimerEvent.TIMER, spawnEnemy);
				
			}else {
				spawnTimer = new Timer(0, 1);
			}
			
			spawnTimer.addEventListener(TimerEvent.TIMER_COMPLETE, doneWaveSpawn);
			spawnTimer.start();
		}
		
		private function spawnEnemy(t:TimerEvent):void {
			var timerE : Timer = t.target as Timer;
			var monster : EnemyUnit = wavesToSpawnList[currentWave][timerE.currentCount - 1] as EnemyUnit;
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
		
		public function set position(value:Point):void 
		{
			_position = value;
		}
	}
}