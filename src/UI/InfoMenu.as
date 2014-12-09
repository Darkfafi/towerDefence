package UI 
{
	import flash.display.Sprite;
	import levels.TileSystem;
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
			bgArt.graphics.drawRect(-TileSystem.globalTile.width * 3, -TileSystem.globalTile.height * 3, TileSystem.globalTile.width * 3, TileSystem.globalTile.height * 3);
			bgArt.graphics.endFill();
			addChild(bgArt);
		}
		
	}

}