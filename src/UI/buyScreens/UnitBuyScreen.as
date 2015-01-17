package UI.buyScreens 
{
	import flash.display.Sprite;
	import UI.buttons.BuyButton;
	import units.alies.BuildUnit;
	import units.alies.KnifeUnit;
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
		override protected function placeTitle():void 
		{
			titleImage = new UnitsTabMenuTitle();
			titleImage.x += titleImage.width / 2 + 10;
			super.placeTitle();
		}
		override protected function buttonAssign():void 
		{
			super.buttonAssign();
			var unitButton : Sprite = new BuyButton(new MachineGunUnitButton,MachineGunner);
			buttonList.push(unitButton);
			unitButton = new BuyButton(new KnifeMeleeUnitButton, KnifeUnit);
			buttonList.push(unitButton);
		}
	}

}