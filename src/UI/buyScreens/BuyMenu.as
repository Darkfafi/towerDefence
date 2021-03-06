package UI.buyScreens 
{
	import events.BuyEvent;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import UI.buttons.BuyButton;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class BuyMenu extends Sprite 
	{
		public static const BUTTON_PRESSED : String = "buyButtonPressed";
		
		protected var titleImage : Sprite = new Sprite();
		
		protected var bgArt : MovieClip = new towersBuybgArt();
		
		protected var buttonList : Array = []; // lijst met alle buttons die automatisch worden geplaatst 
		
		//WANNEER ER OP EEN KNOP WORD GEDRUKT LAUNCH COSTUM EVENT MET TOWER ER IN. DAN KAN DE HUD EN DE SPELER ER BIJ.
		
		public function BuyMenu() 
		{
			drawBg();
			placeTitle();
			buttonAssign();
			placeButtons();
		}
		
		protected function placeTitle():void 
		{
			titleImage.y += titleImage.height + 13;
			titleImage.x += titleImage.width - 27;
			addChild(titleImage);
		}
		
		protected function buttonAssign():void 
		{
			
		}
		
		private function placeButtons():void 
		{
			var butPosx : int = 50;
			var butPosy : int = 200;
			for (var i : int = 0; i < buttonList.length; i++) {
				if (i%3 == 0) {
					butPosx = 50;
					butPosy -= buttonList[i].height + 10;
				}else {
					if(i != 0){
						butPosx += buttonList[i].width + 30;
					}
				}
				buttonList[i].x = butPosx;
				buttonList[i].y = butPosy;
				addChild(buttonList[i]);
			}
		}
		protected function drawBg():void 
		{
			addChild(bgArt);
		}
	}
}