package gameControlEngine 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class GameController 
	{
		private var collisionSystem : CollisionSystem = new CollisionSystem();
		
		private var _world : DisplayObjectContainer;
		private var gameObjects : Array = [];
		
		public function GameController(world : DisplayObjectContainer) 
		{
			_world = world;
			_world.addEventListener(GameObject.ADDED, objectAdded);
			_world.addEventListener(GameObject.REMOVED, objectRemoved);
		}
		
		private function objectRemoved(e:Event):void 
		{
			if (e.target is GameObject) {
				var object : GameObject = e.target as GameObject;
				if(object.checkTag(Tags.COLLIDER_TAG)){
					collisionSystem.checkDeletedObjInCollision(object);
				}
				var index : int = gameObjects.indexOf(object);
				gameObjects.splice(index, 1);
			}
		}
		
		private function objectAdded(e:Event):void 
		{
			if (e.target is GameObject) {
				var object : GameObject = e.target as GameObject;
				object.parent.setChildIndex(object, 0);
				gameObjects.push(object);
			}
		}
		
		private function positionGameObjectToLayer():void 
		{
			var objectOnScreen : Array = [];
			var parentObj : Sprite;
			var l : int;
			l = gameObjects.length;
			for (var i : int = 0; i < l; i++) {
				if (gameObjects[i].checkTag(Tags.POSITION_ON_Y_TAG)) {
					objectOnScreen.push(gameObjects[i]);	
				}
			}
			objectOnScreen.sortOn("y", Array.NUMERIC);
			l = objectOnScreen.length;
			for (i = 0; i < l; i++) {
				parentObj = objectOnScreen[i].parent;
				parentObj.setChildIndex(objectOnScreen[i],parentObj.numChildren - 1);
			}
			l = gameObjects.length;
			for (i = 0; i < l; i++) {
				if (gameObjects[i].checkTag(Tags.POSITION_ON_TOP_TAG)) {
					parentObj = gameObjects[i].parent;
					parentObj.setChildIndex(gameObjects[i], parentObj.numChildren - 1);	
				}
			}
		}
		
		public function lisOfObjectType(object : Class) :Array {
			var list : Array = [];
			for (var i : int =  gameObjects.length - 1; i >= 0; i--) {
				if (gameObjects[i] is object) {
					list.push(gameObjects[i]);
				}
			}
			return list;
		}
		
		public function update() :void {
			positionGameObjectToLayer();
			collisionSystem.checkCollision(gameObjects, _world);
			var l : int = gameObjects.length;
			for (var i : int = l - 1; i >= 0; i--) {
				var object : GameObject = gameObjects[i] as GameObject;
				if(object != null){
					if (object.checkTag(Tags.UPDATE_TAG)) {
						object.update();
					}
				}
			}
		}
		public function destroy() :void {
			var l : int = gameObjects.length;
			for (var i : int = l - 1; i >= 0; i--) {
				gameObjects[i].removeObject();
			}
			gameObjects = [];
			_world.removeEventListener(GameObject.ADDED, objectAdded);
			_world.removeEventListener(GameObject.REMOVED, objectRemoved);
		}
	}
}