package UI.buyScreens 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class BuyMenu extends Sprite 
	{
		protected var bgArt : MovieClip = new towersBuybgArt();
		
		
		public function BuyMenu() 
		{
			drawBg();
		}
		
		protected function drawBg():void 
		{
			addChild(bgArt);
		}
		
	}

}