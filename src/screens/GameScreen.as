package screens 
{
	import flash.events.Event;
	import gameControlEngine.GameController;
	import levels.LevelPlacer;
	import playerControl.Player;
	import playerControl.PlayerBase;
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
		
		public var gameController : GameController;
		private var ui : FullUI;
		
		private var player : Player;
		
		public function GameScreen() 
		{
			addEventListener(Event.ADDED_TO_STAGE,init)
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.ENTER_FRAME, update);
			
			addEventListener(PlayerBase.NO_MORE_LIVES, gameOver);
			
			gameController = new GameController(this);
			placeLevel();
			player = new Player(this);
		}
		
		private function gameOver(e:Event):void 
		{
			//show GameOver on screen or something and after that.
			dispatchEvent(new Event(GAME_OVER));
			
		}
		private function update(e:Event):void 
		{
			if (gameRunning) {
				gameController.update();
			}
		}
		
		private function placeLevel():void 
		{
			//chose level from array
			levelPlacer = new LevelPlacer(this);
			ui = new FullUI();
			addChild(levelPlacer);
			levelPlacer.createLevel(0);
			addChild(ui)
		}
		
		override public function destroy():void 
		{
			gameController.destroy();
			levelPlacer.destroy();
			removeEventListener(Event.ENTER_FRAME, update);
			removeEventListener(PlayerBase.NO_MORE_LIVES, gameOver);
			super.destroy();
		}
	}
}