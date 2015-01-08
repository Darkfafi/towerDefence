package UI.buttons 
{
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import gameControlEngine.GameObject;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class BuyButton extends Sprite 
	{
		private var _boughtItem : Class;
		
		public function BuyButton(buttonArt : SimpleButton,boundItem : Class) 
		{
			addChild(buttonArt);
			_boughtItem = boundItem;
		}
		
		public function get boughtItem():GameObject 
		{
			return new _boughtItem;
		}
		
	}

}