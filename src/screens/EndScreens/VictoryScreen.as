package screens.EndScreens 
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import screens.GameScreen;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class VictoryScreen extends Sprite 
	{
		
		private var _bgVicScreen : Sprite = new VictoryGameCompleatBgArt();
		private var _backButton : SimpleButton = new BackButton();
		
		public function VictoryScreen() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(MouseEvent.CLICK, clickedOnMenu,false,0,true);
			addMenu();
		}
		
		private function clickedOnMenu(e:MouseEvent):void 
		{
			if (e.target == _backButton) {
				dispatchEvent(new Event(GameScreen.GAME_OVER, true));
			}
		}
		
		private function addMenu():void 
		{
			addChild(_bgVicScreen);
			
			_backButton.x = stage.stageWidth / 2;
			_backButton.y = stage.stageHeight - 150;
			
			addChild(_backButton);
		}
	}
}