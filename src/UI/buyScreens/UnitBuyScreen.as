package UI.buyScreens 
{
	import flash.display.Sprite;
	import UI.buttons.BuyButton;
	import units.alies.BuildUnit;
	import units.alies.MachineGunner;
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
			var towerButton : Sprite = new BuyButton(new CanonTowerButton,MachineGunner);
			buttonList.push(towerButton);
		}
	}

}