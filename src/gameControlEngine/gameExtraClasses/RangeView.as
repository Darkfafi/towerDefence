package gameControlEngine.gameExtraClasses 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import gameControlEngine.gameExtraClasses.WatchingObject;
	import gameControlEngine.GameObject;
	import gameControlEngine.Tags;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class RangeView extends GameObject
	{
		private var watchingObj : WatchingObject;
		private var _seeAbleObjects : Array = [];
		
		private var viewArt : Sprite = new Sprite();
		
		public function RangeView() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			watchingObj = parent as WatchingObject;
			addTag(Tags.COLLIDER_TAG);
			addTag(Tags.RANGE_COLLIDER_TAG);
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
			_seeAbleObjects = listOfClasses;
		}
		
		public function setAlpha(alphaRange : Number):void 
		{
			viewArt.alpha = alphaRange;
			if(alphaRange > 0){
				addChild(viewArt);
			}else {
				if (contains(viewArt)) {
					removeChild(viewArt);
				}
			}
		}
		override public function onCollisionEnter(other:GameObject):void 
		{
			if(checkIfSeeAble(other) && other != watchingObj){
				super.onCollisionEnter(other);
				watchingObj.addTarget(other);
			}
		}
		override public function onCollisionExit(other:GameObject):void 
		{
			if(checkIfSeeAble(other)){
				super.onCollisionExit(other);
				watchingObj.removeTarget(other);
			}
		}
		//maak hiervan 'checkIfSeeAbleClass' en maak later ook een functie 'checkIfSeeAble' die er naar kijkt of het flying is etc.
		private function checkIfSeeAble(object : Sprite):Boolean {
			var result : Boolean = false;
			for (var i : int = 0; i < _seeAbleObjects.length; i++) {
				var objectClass : Class = _seeAbleObjects[i] as Class;
				if (object is objectClass) {
					result = true;
					break;
				}
			}
			return result;
		}
		
		public function get seeAbleObjects():Array 
		{
			return _seeAbleObjects;
		}
	}

}