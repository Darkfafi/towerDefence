package towers 
{
	import flash.display.Sprite;
	import gameControlEngine.GameObject;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class RangeView extends GameObject
	{
		private var viewArt : Sprite = new Sprite();
		
		public function RangeView() 
		{
			addChild(viewArt);
		}
		
		public function drawRangeView(range : int):void 
		{
			viewArt.graphics.clear();
			viewArt.alpha = 0;
			viewArt.graphics.beginFill(0xFF00FF, 1);
			viewArt.graphics.drawCircle(0, 0, range);
			viewArt.graphics.endFill();
			setHitBox( -viewArt.width / 2, - viewArt.height / 2, viewArt.width, viewArt.height);
		}
		
		public function setAlpha(alphaRange : Number):void 
		{
			viewArt.alpha = alphaRange;
		}
		override public function onCollisionEnter(other:GameObject):void 
		{
			if(other is Tower == false && other is RangeView == false){
				super.onCollisionEnter(other);
			}
		}
		
	}

}