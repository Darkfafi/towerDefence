package screens 
{
	import events.levelSwitchEvent;
	import flash.display.Stage;
	import flash.events.Event;
	import levels.Level;
	import playerControl.PlayerBase;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class ScreenManager 
	{
		public static const  MENU_SCREEN : String = "menuScreen";
		public static const  GAME_SCREEN : String = "gameScreen";
		
		private var menu : Screen;
		private var game : Screen;
		
		private var stage : Stage;
		
		
		public function ScreenManager(_stage : Stage) 
		{
			stage = _stage;
		}
		
		public function switchScreen(screen : String,levelToStart : int = 0) :void {
			switch(screen) {
				case GAME_SCREEN:
					if (menu != null && stage.contains(menu)) {
						menu.destroy();
						menu.removeEventListener(MenuScreen.START_GAME, startGame);
						stage.removeChild(menu);
						menu = null;
					}
					game = new GameScreen(levelToStart);
					game.addEventListener(GameScreen.GAME_OVER, gameOver);
					game.addEventListener(Level.LEVEL_EVENT, switchLevel);
					stage.addChild(game);
				break
				case MENU_SCREEN:
					if (game != null && stage.contains(game)) {
						game.destroy();
						game.removeEventListener(GameScreen.GAME_OVER, gameOver);
						stage.removeChild(game);
						game = null;
					}
					menu = new MenuScreen();
					menu.addEventListener(MenuScreen.START_GAME, startGame);
					stage.addChild(menu);
				break
				
			}
		}
		
		private function startGame(e:levelSwitchEvent):void 
		{
			switchScreen(GAME_SCREEN, e.level);
		}
		
		private function switchLevel(e:Event):void 
		{
			var lvlEvent : levelSwitchEvent = e as levelSwitchEvent;
			if (game != null && stage.contains(game)) {
				game.destroy();
				game.removeEventListener(GameScreen.GAME_OVER, gameOver);
				game.removeEventListener(Level.LEVEL_EVENT, switchLevel);
				stage.removeChild(game);
				game = null;
			}
			game = new GameScreen(lvlEvent.level);
			game.addEventListener(GameScreen.GAME_OVER, gameOver);
			game.addEventListener(Level.LEVEL_EVENT, switchLevel);
			stage.addChild(game);
		}
		
		
		
		private function gameOver(e:Event):void 
		{
			switchScreen(MENU_SCREEN);
		}
		
	}
}