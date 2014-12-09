package UI 
{
	import flash.display.Sprite;
	import levels.TileSystem;
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
			bgArt.graphics.drawRect(0 * 4, -TileSystem.globalTile.height * 4, TileSystem.globalTile.width * 4, TileSystem.globalTile.height * 4);
			bgArt.graphics.endFill();
			addChild(bgArt);
		}
		
	}

}