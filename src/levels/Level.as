package levels 
{
	import events.HudEvent;
	import events.levelSwitchEvent;
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
		public static const LEVEL_EVENT : String = "levelSwitchEvent";
		
		private var _levelId : int;
		
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
			var timer : Timer = new Timer(1000, _timeTillLevelStarts * 0.001);
			timer.addEventListener(TimerEvent.TIMER, startFirstWaveCount);
			timer.start();
		}
		
		private function startFirstWaveCount(e:TimerEvent):void 
		{
			var timer : Timer = e.target as Timer;
			
			sendUIData(UiGlobalInfo.WAVE_INFO, "Incoming in.. " + (timer.repeatCount - timer.currentCount));
			
			if(timer.currentCount == timer.repeatCount){
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER, startFirstWaveCount);
				spawnWave(_currentWave);
			}
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
			sendUIData(UiGlobalInfo.WAVE_INFO, waveInt.toString());
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
		
		public function set levelId(value:int):void 
		{
			_levelId = value;
		}
		
		public function get levelId():int 
		{
			return _levelId;
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
			//trace(_spawnsDoneSpawning);
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
				var levelEvent : levelSwitchEvent = new levelSwitchEvent(LEVEL_EVENT, levelId + 1, true);
				_world.dispatchEvent(levelEvent);
				//dispatches event so the levelPlacer can remove this level and place the next level.
			}else {
				timerTillNextWave = new Timer(1000, _timeUntilNextWave * 0.001);
				timerTillNextWave.addEventListener(TimerEvent.TIMER, nextWaveCountDown);
				timerTillNextWave.start();
			}
		}
		
		private function nextWaveCountDown(e:TimerEvent):void 
		{
			var timer : Timer = e.target as Timer;
			sendUIData(UiGlobalInfo.WAVE_INFO, "Seconds left " + (timer.repeatCount - timer.currentCount));
			
			if(timer.currentCount == timer.repeatCount){
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER, nextWaveCountDown);
				startNextWave();
			}
			
		}
		
		private function startNextWave():void 
		{
			trace("NEXT WAVE");
			_currentWave += 1;
			spawnWave(_currentWave);
		}
		
		private function sendUIData(type : String, data : String) :void {
			var hudEvent : HudEvent = new HudEvent(UiGlobalInfo.GLOBAL_UI_INFO, type, data, true);
			_world.dispatchEvent(hudEvent);
		}
		
		public function destroy() :void {
			_world.removeEventListener(Event.REMOVED_FROM_STAGE, objectRemoved, true);
			_world.removeEventListener(SpawnPoint.DONE_WAVE, SpawnPointDoneWithWave);
			timerTillNextWave.removeEventListener(TimerEvent.TIMER, nextWaveCountDown);
			timerTillNextWave.stop();
			
			for (var i : int = 0; i < _spawnPoints.length; i++) {
				_spawnPoints[i].destroy();
			}
		}
	}	
}