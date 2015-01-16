package screens 
{
	import events.levelSwitchEvent;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import media.SoundManager;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class MenuScreen extends Screen
	{
		public static const START_GAME : String = "StartGameScreen";
		
		private var _backgroundArt : Sprite = new MenuBg();
		
		private var _startButton : SimpleButton = new MenuStartButton();
		
		public function MenuScreen() 
		{
			addEventListener(MouseEvent.CLICK, clickedOnMenu);
			addEventListener(Event.ADDED_TO_STAGE, init);
			addChild(_backgroundArt);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			placeButtons();
			SoundManager.playMusic(SoundManager.MENU_MUSIC);
		}
		
		private function clickedOnMenu(e:MouseEvent):void 
		{
			if (e.target == _startButton) {
				var startGame : levelSwitchEvent = new levelSwitchEvent(START_GAME, 0);
				dispatchEvent(startGame);
			}
		}
		
		private function placeButtons():void 
		{
			_startButton.x = stage.stageWidth / 2;
			_startButton.y = stage.stageHeight / 2;
			addChild(_startButton);
		}
		override public function destroy():void 
		{
			removeEventListener(MouseEvent.CLICK, clickedOnMenu);
			super.destroy();
		}
	}
}