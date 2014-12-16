package screens 
{
	import flash.events.Event;
	import gameControlEngine.GameController;
	import levels.Levels;
	import playerControl.Player;
	import UI.FullUI;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class GameScreen extends Screen
	{
		private var gameRunning : Boolean = true;
		private var gameController : GameController;
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
			
			gameController = new GameController(this);
			placeLevel();
			player = new Player(this);
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
			var level : Levels = new Levels();
			ui = new FullUI();
			addChild(level);
			addChild(ui)
		}
	}
}