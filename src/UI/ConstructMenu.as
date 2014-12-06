package UI 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class ConstructMenu extends Sprite
	{
		private var bgArt : Sprite = new Sprite();
		
		public function ConstructMenu() 
		{
			drawBg();
		}
		
		private function drawBg():void 
		{
			bgArt.graphics.beginFill(0x696969, 1);
			bgArt.graphics.drawRect(0, -50, 50, 50);
			bgArt.graphics.endFill();
			addChild(bgArt);
		}
		
	}

}