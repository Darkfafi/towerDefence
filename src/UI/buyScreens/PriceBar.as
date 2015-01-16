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
		private var _priceBarOpen : MovieClip = new PriceTagOpen();
		private var _priceBarIdle : MovieClip = new PriceTagIdle();
		
		private var _priceBarText : HudTextField = new HudTextField("COST");
		
		public function PriceBar() 
		{
			super();
			_priceBarText.x += 25;
			_priceBarText.y += 10;
			_priceBarOpen.gotoAndStop(1);
		}
		
		public function showCost(cost : int) :void {
			_priceBarOpen.gotoAndPlay(1);
			_priceBarText.changeText(cost.toString());
			
			addEventListener(Event.ENTER_FRAME, checkAnim);
			
			addChild(_priceBarOpen);
		}
		
		public function hide():void 
		{
			removeEventListener(Event.ENTER_FRAME, checkAnim);
			_priceBarOpen.gotoAndStop(1);
			
			if(contains(_priceBarOpen)){
				removeChild(_priceBarOpen);
			}
			if (contains(_priceBarIdle)) {
				removeChild(_priceBarIdle);
			}
			if(contains(_priceBarText)){
				removeChild(_priceBarText);
			}
		}
		
		private function checkAnim(e:Event):void 
		{
			if (_priceBarOpen.currentFrame == _priceBarOpen.totalFrames) {
				removeEventListener(Event.ENTER_FRAME, checkAnim);
				addChild(_priceBarIdle);
				addChild(_priceBarText);
				removeChild(_priceBarOpen);
			}
		}
		
		public function priceBarArt():Boolean 
		{
			var result : Boolean = false;
			if (contains(_priceBarIdle) || contains(_priceBarOpen)) {
				result = true;
			}
			return result;
		}
	}

}