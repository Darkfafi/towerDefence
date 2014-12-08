package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Tile extends Sprite
	{
		public function Tile() 
		{
			defaultTile();
		}
		public function defaultTile(color : uint = 0x000000) :void {
			graphics.clear();
			graphics.beginFill(color, 1);
			graphics.lineStyle(1, 0x0000FF, 1);
			graphics.drawRect(0, 0, 66, 49);
			graphics.endFill();
			alpha = 0.05;
		}
		public function positiveTile() :void {
			defaultTile(0x00FF00);
			alpha = 0.5;
		}
		public function negativeTile() :void {
			defaultTile(0xFF0000);
			alpha = 0.4;
		}
		
	}

}