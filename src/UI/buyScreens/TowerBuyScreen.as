package UI.buyScreens 
{
	import flash.display.Sprite;
	import towers.antiGroundTowers.CanonTower;
	import UI.buttons.BuyButton;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class TowerBuyScreen extends BuyMenu 
	{
		
		public function TowerBuyScreen() 
		{
			super();
			//misschien een button place functie die allebuttons zelf op de goede plek zet vanuit een array ofzo.
		}
		override protected function buttonAssign():void 
		{
			super.buttonAssign();
			for (var i : int = 0; i < 6; i++){
			var cannonTowerButton : Sprite = new BuyButton(new CanonTowerButton,new CanonTower);
			
			buttonList.push(cannonTowerButton);
			}
		}
	}
}