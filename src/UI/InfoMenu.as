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
		}
		
		private function drawBg():void 
		{
			bgArt.graphics.beginFill(0x969696, 1);
			bgArt.graphics.drawRect(-50, -50, 50, 50);
			bgArt.graphics.endFill();
			addChild(bgArt);
		}
		
	}

}