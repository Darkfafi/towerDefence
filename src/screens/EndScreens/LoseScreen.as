package screens.EndScreens 
{
	import events.levelSwitchEvent;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import levels.Level;
	import screens.GameScreen;
	import screens.Screen;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class LoseScreen extends Sprite 
	{
		private var _currentLevel : int;
		private var _backgroundLoseScreen : Sprite = new LoseScreenBg();
		private var _gotoMenuButton : SimpleButton = new BackToMenuButton();
		private var _retryButton : SimpleButton = new RetryLevelButton();
		
		public function LoseScreen(curlevel : int) 
		{
			super();
			_currentLevel = curlevel;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(MouseEvent.CLICK, clickedOnMenu);
			addMenu();
		}
		
		private function clickedOnMenu(e:MouseEvent):void 
		{
			if (e.target == _gotoMenuButton) {
				dispatchEvent(new Event(GameScreen.GAME_OVER, true));
			}else if(e.target == _retryButton) {
				var levelEvent : levelSwitchEvent = new levelSwitchEvent(Level.LEVEL_EVENT, _currentLevel, true);
				dispatchEvent(levelEvent);
			}
		}
		
		private function addMenu():void 
		{
			addChild(_backgroundLoseScreen);
			
			_gotoMenuButton.y = _retryButton.y += _backgroundLoseScreen.height - 52;
			_retryButton.x += _backgroundLoseScreen.width - 72;
			_gotoMenuButton.x += 72;
			
			addChild(_gotoMenuButton);
			addChild(_retryButton);
		}
		
	}

}