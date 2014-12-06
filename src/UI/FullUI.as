package UI 
{
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class FullUI extends Sprite
	{
		private var constructMenu : ConstructMenu;
		private var infoMenu : InfoMenu;
		
		public function FullUI() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			//geef player mee in parameter zodat alle menus erbij kunnen.
			
			constructMenu = new ConstructMenu();
			infoMenu = new InfoMenu();
			
			
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			constructMenu.y = stage.stageHeight;
			infoMenu.x = stage.stageWidth;
			infoMenu.y = stage.stageHeight;
			
			addChild(constructMenu);
			addChild(infoMenu);
		}
		
	}

}