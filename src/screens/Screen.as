package screens 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Screen extends Sprite
	{
		public function destroy() :void {
			//remove all eventlisteners first!
			var l : int = this.numChildren;
			var cur : DisplayObject;
			
			for (var i : int = l - 1; i >= 0; i--) {
				cur = getChildAt(i);
				if (cur is Sprite) {
					removeChild(cur);
				}
			}
			cur = null;
			i = l = NaN;
		}
	}

}