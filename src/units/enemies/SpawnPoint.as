package units.enemies 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import levels.TileSystem;
	import units.enemies.groundUnits.EnemyClawRobot;
	import units.enemies.groundUnits.EnemyUnit;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class SpawnPoint
	{
		public static const DONE_WAVE : String = "doneWithWaveSpawn";
		
		private var spawnTimer : Timer;
		private var currentWave : int;
		public var wavesToSpawnList : Array = []; //in deze array komt een set van arrays. elke array is een wave die gespawnd word.
		
		private var _position : Point = new Point();
		private var _world : DisplayObjectContainer;
		
		public function SpawnPoint(world : DisplayObjectContainer) 
		{
			_world = world;
		}
		
		public function spawnWave(waveInt : int, timeTillNextEnemy : int = 1500) :void {
			
			currentWave = waveInt - 1;
			if(waveSpawnAble(waveInt)){
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
			monster.x = _position.x + TileSystem.globalTile.width / 2;
			monster.y = _position.y + TileSystem.globalTile.height / 2;
			_world.addChild(monster);
		}
		
		private function doneWaveSpawn(t:TimerEvent):void 
		{
			spawnTimer.reset();
			spawnTimer.stop();
			
			_world.dispatchEvent(new Event(DONE_WAVE,true));
			
			//trace("DONE WITH WAVE " + (currentWave + 1)); //met een dispatchevent. in de level class word er in de functie ++ gedaan op een counter.
			//Als counter gelijk is aan de hoeveelheid spawnpoints en alle enemies zijn dood dan reset de counter en ga naar volgende wave
			
			spawnTimer.removeEventListener(TimerEvent.TIMER, spawnEnemy);
			spawnTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, doneWaveSpawn);
		}
		
		public function set position(value:Point):void 
		{
			_position = value;
		}
		
		public function waveSpawnAble(waveInt : int) : Boolean {
			var result : Boolean = false;
			if (wavesToSpawnList[waveInt - 1] != null) {
				result = true;
			}
			return result;
		}
		
		public function destroy() :void {
			spawnTimer.stop();
			spawnTimer.removeEventListener(TimerEvent.TIMER, spawnEnemy);
			spawnTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, doneWaveSpawn);
		}
	}
}