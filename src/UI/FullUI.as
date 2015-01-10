package UI 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import gameControlEngine.GameObject;
	import gameControlEngine.Tags;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class FullUI extends Sprite
	{
		private var constructMenu : ConstructMenu;
		private var infoMenu : InfoMenu;
		private var uiGlobalInfo : UiGlobalInfo;
		
		public function FullUI() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			
			constructMenu = new ConstructMenu();
			infoMenu = new InfoMenu();
			uiGlobalInfo = new UiGlobalInfo();
		}
		
		public function destroy():void 
		{
			infoMenu.destroy();
			constructMenu.destroy();
			
			parent.removeEventListener(InfoMenu.SHOW_INFO, infoMenu.setInfoText);
			parent.removeEventListener(InfoMenu.CLOSE_INFO, infoMenu.closeInfoText);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			constructMenu.y = stage.stageHeight;
			infoMenu.x = stage.stageWidth;
			infoMenu.y = stage.stageHeight;
			
			parent.addEventListener(InfoMenu.SHOW_INFO, infoMenu.setInfoText);
			parent.addEventListener(InfoMenu.CLOSE_INFO, infoMenu.closeInfoText);
			
			addChild(constructMenu);
			addChild(infoMenu);
			addChild(uiGlobalInfo);
		}
		
	}

}