package screens 
{
	import flash.events.Event;
	import gameControlEngine.GameController;
	import levels.Level;
	import levels.LevelPlacer;
	import playerControl.Player;
	import playerControl.PlayerBase;
	import screens.EndScreens.LoseScreen;
	import UI.FullUI;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class GameScreen extends Screen
	{
		public static const GAME_OVER : String = "gameOver";
		
		private var gameRunning : Boolean = true;
		
		private var levelPlacer : LevelPlacer;
		
		private var _levelToSpawn : int;
		
		public var gameController : GameController;
		private var ui : FullUI;
		
		public var player : Player;
		
		public function GameScreen(levelToSpawn : int = 0) 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			_levelToSpawn = levelToSpawn;
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.ENTER_FRAME, update);
			
			addEventListener(PlayerBase.NO_MORE_LIVES, gameOver);
			
			gameController = new GameController(this);
			placeLevel(_levelToSpawn);
		}
		
		private function gameOver(e:Event):void 
		{
			//show GameOver on screen or something and after that.
			//dispatchEvent(new Event(GAME_OVER));
			gameRunning = false;
			var loseScreen : LoseScreen = new LoseScreen(_levelToSpawn);
			loseScreen.x = 200;
			loseScreen.y = 190;
			addChild(loseScreen);
		}
		private function update(e:Event):void 
		{
			if (gameRunning) {
				gameController.update();
			}
		}
		
		private function placeLevel(levelInt : int):void 
		{
			//chose level from array
			levelPlacer = new LevelPlacer(this);
			if(levelPlacer.checkIfCanBePlaced(levelInt)){
				ui = new FullUI(this);
				addChild(levelPlacer);
				var level : Level = levelPlacer.createLevel(levelInt);
				player = new Player(this);
				level.startLevel(1); //als die niet bestaat dan ga terug naar menu met event die daarvoor zorgt
				addChild(ui)
			}else {
				dispatchEvent(new Event(GameScreen.GAME_OVER));
			}
		}
		
		override public function destroy():void 
		{
			if(contains(levelPlacer)){
				player.destroy();
				gameController.destroy();
				levelPlacer.destroy();
				ui.destroy();
			}
			removeEventListener(Event.ENTER_FRAME, update);
			removeEventListener(PlayerBase.NO_MORE_LIVES, gameOver);
			super.destroy();
		}
	}
}