package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import media.SoundManager;
	import screens.ScreenManager;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Main extends Sprite 
	{
		public static const START_GAME : String = "StartGameScreen";
		
		private var screenManager : ScreenManager;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			SoundManager.loadSounds();
			addEventListener(Event.ENTER_FRAME, checkSoundsLoaded);
		}
		
		private function checkSoundsLoaded(e:Event):void 
		{
			if (SoundManager.allSoundsLoaded) {
				removeEventListener(Event.ENTER_FRAME, checkSoundsLoaded);
				screenManager = new ScreenManager(stage);
				screenManager.switchScreen(ScreenManager.MENU_SCREEN);
			}
		}
	}
}