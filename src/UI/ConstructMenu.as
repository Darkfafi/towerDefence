package UI 
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import levels.TileSystem;
	import UI.buyScreens.BuyMenu;
	import UI.buyScreens.TowerBuyScreen;
	import UI.buyScreens.UnitBuyScreen;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class ConstructMenu extends Sprite
	{
		private static const TOWER_SCREEN : int = 0;
		private static const UNIT_SCREEN : int = 1;
		
		private var allBuyScreens : Array = [new TowerBuyScreen, new UnitBuyScreen];
		
		private var towerTabButton  : SimpleButton = new TowersTabButton(),
					unitsTabButton  : SimpleButton = new UnitsTabButton(),
					specialTabButton : SimpleButton = new SpecialTabButton();
					
		public function ConstructMenu() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			addScreens();
			addNavTabs();
		}
		
		private function addScreens():void 
		{
			for (var i : int = 0; i < allBuyScreens.length; i++) {
				var screen : BuyMenu = allBuyScreens[i];
				screen.y -= screen.height;
				addChild(screen);
				screen.visible = false;
				allBuyScreens[i] = screen;
			}
		}
		
		private function switchBuyScreen(screenConst : int) :void {
			
			if (allBuyScreens[screenConst].visible) {
				allBuyScreens[screenConst].visible = false;
			}else{				
				for (var i : int = 0; i < allBuyScreens.length; i++) {
					allBuyScreens[i].visible = false;
				}
				allBuyScreens[screenConst].visible = true;
			}
		}
		
		private function addNavTabs():void 
		{
			towerTabButton.x = 50;
			towerTabButton.y = unitsTabButton.y = specialTabButton.y -= 10;
			unitsTabButton.x = towerTabButton.x + unitsTabButton.width +30;
			specialTabButton.x = unitsTabButton.x + specialTabButton.width + 30;
			
			addChild(towerTabButton);
			addChild(unitsTabButton);
			addChild(specialTabButton);
			
			addEventListener(MouseEvent.CLICK, clickedOnMenu);
		}
		
		private function clickedOnMenu(e:MouseEvent):void 
		{
			if (e.target == towerTabButton) {
				switchBuyScreen(TOWER_SCREEN);
			}else if (e.target == unitsTabButton) {
				switchBuyScreen(UNIT_SCREEN);
			}
		}
		public function destroy() :void {
			removeEventListener(MouseEvent.CLICK, clickedOnMenu);
		}
	}
}