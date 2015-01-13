package UI.buyScreens 
{
	import flash.display.Sprite;
	import UI.buttons.BuyButton;
	import units.alies.BuildUnit;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class UnitBuyScreen extends BuyMenu 
	{
		
		public function UnitBuyScreen() 
		{
			super();
			
		}
		override protected function buttonAssign():void 
		{
			super.buttonAssign();
			var towerButton : Sprite = new BuyButton(new CanonTowerButton,BuildUnit);
			buttonList.push(towerButton);
		}
	}

}