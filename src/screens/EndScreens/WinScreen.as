package screens.EndScreens 
{
	import events.levelSwitchEvent;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import levels.Level;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class WinScreen extends Sprite 
	{
		private var _levelId : int;
		
		private var _winMenuBg : Sprite = new WinMenuBgArt();
		private var _continueButton : SimpleButton = new ContinueButton();
		
		public function WinScreen(levelId : int) 
		{
			super();
			_levelId = levelId;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(MouseEvent.CLICK, clickedOnMenu, false, 0, true);
			addMenu();
		}
		
		private function addMenu():void 
		{
			addChild(_winMenuBg);
			_continueButton.y += 70;
			addChild(_continueButton);
		}
		
		private function clickedOnMenu(e:MouseEvent):void 
		{
			if (e.target == _continueButton) {
				var levelEvent : levelSwitchEvent = new levelSwitchEvent(Level.LEVEL_EVENT, _levelId + 1, true); 
				dispatchEvent(levelEvent);
			}
		}
		
	}

}