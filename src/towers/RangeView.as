package towers 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import gameControlEngine.GameObject;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class RangeView extends GameObject
	{
		private var viewingTower : Tower;
		private var seeAbleObjects : Array = [];
		
		private var viewArt : Sprite = new Sprite();
		
		public function RangeView() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			addChild(viewArt);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			viewingTower = parent as Tower;
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
		
		public function setSeeAbleObjects(listOfClasses : Array) :void 
		{
			seeAbleObjects = listOfClasses;
		}
		
		public function setAlpha(alphaRange : Number):void 
		{
			viewArt.alpha = alphaRange;
		}
		override public function onCollisionEnter(other:GameObject):void 
		{
			if(checkIfSeeAble(other)){
				super.onCollisionEnter(other);
				viewingTower.addTarget(other);
			}
		}
		override public function onCollisionExit(other:GameObject):void 
		{
			if(checkIfSeeAble(other)){
				super.onCollisionExit(other);
				viewingTower.removeTarget(other);
			}
		}
		//maak hiervan 'checkIfSeeAbleClass' en maak later ook een functie 'checkIfSeeAble' die er naar kijkt of het flying is etc.
		private function checkIfSeeAble(object : Sprite):Boolean {
			var result : Boolean = false;
			for (var i : int = 0; i < seeAbleObjects.length; i++) {
				var objectClass : Class = seeAbleObjects[i] as Class;
				if (object is objectClass) {
					result = true;
					break;
				}
			}
			return result;
		}
	}

}