package gameControlEngine.gameExtraClasses 
{
	import gameControlEngine.GameObject;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class WatchingObject extends GameObject 
	{
		protected var rangeView : RangeView = new RangeView();
		
		protected var targetObjects : Array = [];
		
		public function WatchingObject() 
		{
			super();
			
		}
		
		public function addTarget(targetObj:GameObject):void 
		{
			targetObjects.push(targetObj);
		}
		
		public function removeTarget(targetObj:GameObject):void 
		{
			var index : int = targetObjects.indexOf(targetObj);
			targetObjects.splice(index, 1);
		}
		
		override public function removeObject():void 
		{
			rangeView.removeObject();
			super.removeObject();
		}
	}
}