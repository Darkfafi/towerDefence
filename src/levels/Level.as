package levels 
{
	import events.HudEvent;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import gameControlEngine.GameObject;
	import screens.GameScreen;
	import UI.UiGlobalInfo;
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
		
		protected var _world : DisplayObjectContainer;
		protected var _game : GameScreen;
		
		//level controll vars
		private var _spawnsDoneSpawning : int;
		private var _currentWave : int;
		
		protected var _timeTillLevelStarts : int = 2000;
		protected var _timeUntilNextWave : int = 3000;
		
		private var timerTillNextWave : Timer;
		protected var levelStartGold : int;
		
		public function Level() 
		{
			setLevelInfo();
		}
		public function setWorld(world : DisplayObjectContainer):void {
			_world = world;
			
			_game = _world as GameScreen;
			
			loopLevel();
			setSpawnInfo();
			
			_world.addEventListener(Event.REMOVED_FROM_STAGE, objectRemoved, true);
			
			_world.addEventListener(SpawnPoint.DONE_WAVE, SpawnPointDoneWithWave);
		}
		protected function setSpawnInfo():void 
		{
			
		}
		
		protected function setLevelInfo():void 
		{
			
		}
		public function startLevel(waveInt : int = 1) :void {
			_game.player.setGoldAmount(levelStartGold);
			_currentWave = waveInt;
			var timer : Timer = new Timer(_timeTillLevelStarts, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, startFirstWave);
			timer.start();
		}
		
		private function startFirstWave(e:TimerEvent):void 
		{
			var timer : Timer = e.target as Timer;
			timer.stop();
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, startFirstWave);
			
			spawnWave(_currentWave)
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
			var hudEvent : HudEvent = new HudEvent(UiGlobalInfo.GLOBAL_UI_INFO, UiGlobalInfo.WAVE_INFO, waveInt, true);
			_world.dispatchEvent(hudEvent);
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
		
		//level controller (kan je voor elk level aanpassen vanwegen tutorial levels etc)
		private function SpawnPointDoneWithWave(e:Event):void 
		{
			_spawnsDoneSpawning ++;
			trace(_spawnsDoneSpawning);
		}
		protected function objectRemoved(e:Event):void {
			if (e.target is EnemyUnit) {
				var enemiesLeft : int = _game.gameController.lisOfObjectType(EnemyUnit).length;
				if (enemiesLeft == 0 && _spawnsDoneSpawning == _spawnPoints.length) {
					_spawnsDoneSpawning = 0;
					waveDone();
				}
			}
		}	
		protected function waveDone():void {
			var spawnsCantSpawn : int = 0;
			for (var i : int = 0; i < _spawnPoints.length; i++) {
				if (_spawnPoints[i].waveSpawnAble(_currentWave + 1) == false) {
					spawnsCantSpawn ++;
				}
			}
			if (spawnsCantSpawn == _spawnPoints.length) {
				trace("NEXT LEVEL");
				//dispatches event so the levelPlacer can remove this level and place the next level.
			}else {
				timerTillNextWave = new Timer(_timeUntilNextWave, 1);
				timerTillNextWave.addEventListener(TimerEvent.TIMER_COMPLETE, nextWaveTimerDone);
				timerTillNextWave.start();
			}
		}
		
		private function nextWaveTimerDone(e:TimerEvent):void 
		{
			var timer : Timer = e.target as Timer;
			timer.stop();
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, nextWaveTimerDone);
			
			startNextWave();
		}
		
		private function startNextWave():void 
		{
			trace("NEXT WAVE");
			_currentWave += 1;
			spawnWave(_currentWave);
		}
		
		public function destroy() :void {
			_world.removeEventListener(Event.REMOVED_FROM_STAGE, objectRemoved, true);
			_world.removeEventListener(SpawnPoint.DONE_WAVE, SpawnPointDoneWithWave);
			timerTillNextWave.removeEventListener(TimerEvent.TIMER_COMPLETE, nextWaveTimerDone);
			timerTillNextWave.stop();
			
			for (var i : int = 0; i < _spawnPoints.length; i++) {
				_spawnPoints[i].destroy();
			}
		}
	}	
}