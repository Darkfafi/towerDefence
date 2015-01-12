package UI.buyScreens 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import UI.HudTextField;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class PriceBar extends Sprite 
	{
		private var _priceBarArt : MovieClip = new PriceTabArt();
		private var _priceBarText : HudTextField = new HudTextField("COST");
		
		public function PriceBar() 
		{
			super();
			_priceBarText.x += 45;
			_priceBarText.y += 10;
			_priceBarArt.gotoAndStop(1);
		}
		
		public function showCost(cost : int) :void {
			_priceBarArt.gotoAndPlay(1);
			_priceBarText.changeText(cost.toString());
			
			addEventListener(Event.ENTER_FRAME, checkAnim);
			
			addChild(_priceBarArt);
			trace("fdsffsd");
		}
		
		public function hide():void 
		{
			removeEventListener(Event.ENTER_FRAME, checkAnim);
			_priceBarArt.gotoAndStop(1);
			
			if(contains(_priceBarArt)){
				removeChild(_priceBarArt);
			}
			if(contains(_priceBarText)){
				removeChild(_priceBarText);
			}
		}
		
		private function checkAnim(e:Event):void 
		{
			if (_priceBarArt.currentFrame == _priceBarArt.totalFrames) {
				removeEventListener(Event.ENTER_FRAME, checkAnim);
				addChild(_priceBarText);
				_priceBarArt.stop();
			}
		}
		
		public function get priceBarArt():MovieClip 
		{
			return _priceBarArt;
		}
	}

}