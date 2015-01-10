package UI 
{
	import flash.display.DisplayObjectContainer;
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
		
		public function FullUI(game : DisplayObjectContainer) 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			uiGlobalInfo = new UiGlobalInfo(game);
			constructMenu = new ConstructMenu();
			infoMenu = new InfoMenu();
		
		}
		
		public function destroy():void 
		{
			infoMenu.destroy();
			constructMenu.destroy();
			uiGlobalInfo.destroy();
			
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