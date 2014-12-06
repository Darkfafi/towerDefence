package screens 
{
	import flash.display.Stage;
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
		
		public function switchScreen(screen : String) :void {
			switch(screen) {
				case GAME_SCREEN:
					if (menu != null && stage.contains(menu)) {
						menu.destroy();
						stage.removeChild(menu);
						menu = null;
					}
					game = new GameScreen();
					stage.addChild(game);
				break
				case MENU_SCREEN:
					if (game != null && stage.contains(game)) {
						game.destroy();
						stage.removeChild(game);
						game = null;
					}
					menu = new MenuScreen();
					stage.addChild(menu);
				break
				
			}
		}
		
	}

}