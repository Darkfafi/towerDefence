package UI 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class HpBar extends Sprite 
	{
		private var _maxHp : Number;
		private var backBar : Sprite = new Sprite();
		private var barArt : Sprite = new Sprite();
		
		public function HpBar(hp : Number) 
		{
			_maxHp = hp;
			
			backBar.graphics.beginFill(0xFF2222,0.7);
			backBar.graphics.drawRect(0, 0, 40, 5);
			backBar.graphics.endFill();
			
			barArt.graphics.beginFill(0x00FF00);
			barArt.graphics.drawRect(0, 0, 40, 5);
			barArt.graphics.endFill();
			
			scaleBar(_maxHp);
			addChild(backBar);
			addChild(barArt);
			
			this.x -= this.width / 2;
		}
		
		public function scaleBar(newHp : Number) :void {
			barArt.scaleX = (newHp / _maxHp);
		}
		
		public function get maxHp():Number 
		{
			return _maxHp;
		}
		
	}

}