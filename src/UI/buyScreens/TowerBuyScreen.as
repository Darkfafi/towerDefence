package UI.buyScreens 
{
	import flash.display.Sprite;
	import towers.antiGroundTowers.CanonTower;
	import towers.antiGroundTowers.SkyLaserTower;
	import towers.antiGroundTowers.TeslaTower;
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
			var towerButton : Sprite = new BuyButton(new CanonTowerButton,CanonTower);
			buttonList.push(towerButton);
			towerButton = new BuyButton(new TeslaTowerButton , TeslaTower);
			buttonList.push(towerButton);
			towerButton = new BuyButton(new SkyLaserTowerButton, SkyLaserTower);
			buttonList.push(towerButton);
		}
	}
}