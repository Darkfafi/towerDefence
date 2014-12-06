package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import screens.ScreenManager;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Main extends Sprite 
	{
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
			screenManager = new ScreenManager(stage);
			screenManager.switchScreen(ScreenManager.GAME_SCREEN);
		}
		
	}
	
}