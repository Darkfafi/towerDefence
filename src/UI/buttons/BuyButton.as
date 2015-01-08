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
		private var _boughtItem : GameObject;
		
		public function BuyButton(buttonArt : SimpleButton,boundItem : GameObject) 
		{
			addChild(buttonArt);
			_boughtItem = boundItem;
		}
		
		public function get boughtItem():GameObject 
		{
			return _boughtItem;
		}
		
	}

}