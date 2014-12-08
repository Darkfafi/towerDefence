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
			alpha = 0.8;
		}
		
		private function drawBg():void 
		{
			bgArt.graphics.beginFill(0x696969, 1);
			bgArt.graphics.drawRect(0, -150, 300, 150);
			bgArt.graphics.endFill();
			addChild(bgArt);
		}
		
	}

}