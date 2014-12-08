package UI 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class InfoMenu extends Sprite
	{
		
		private var bgArt : Sprite = new Sprite();
		
		public function InfoMenu() 
		{
			drawBg();
			alpha = 0.8;
		}
		
		private function drawBg():void 
		{
			bgArt.graphics.beginFill(0x969696, 1);
			bgArt.graphics.drawRect(-250, -150, 250, 150);
			bgArt.graphics.endFill();
			addChild(bgArt);
		}
		
	}

}