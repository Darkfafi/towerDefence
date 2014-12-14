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
				gameObjects.push(object);
			}
		}
		
		private function positionGameObjectToLayer():void 
		{
			var objectOnScreen : Array = [];
			var parentObj : Sprite;
			for (var i : int = 0; i < gameObjects.length; i++) {
				if (gameObjects[i].checkTag(Tags.POSITION_ON_Y_TAG)) {
					objectOnScreen.push(gameObjects[i]);	
				}
			}
			objectOnScreen.sortOn("y", Array.NUMERIC);
			
			for (i = 0; i < objectOnScreen.length; i++) {
				parentObj = objectOnScreen[i].parent;
				parentObj.addChild(objectOnScreen[i]);
			}
			for (i = 0; i < gameObjects.length; i++) {
				if (gameObjects[i].checkTag(Tags.POSITION_ON_TOP_TAG)) {
					parentObj = gameObjects[i].parent;
					parentObj.addChild(gameObjects[i]);	
				}
			}
			
		}
		
		public function lisOfObjectType(object : GameObject) :Array {
			var list : Array = [];
			for (var i : int = 0; i < gameObjects.length; i++) {
				if (gameObjects[i] == object) {
					list.push(gameObjects[i]);
				}
			}
			return list;
		}
		public function update() :void {
			positionGameObjectToLayer();
			collisionSystem.checkCollision(gameObjects,_world);
			var l : int = gameObjects.length;
			for (var i : int = l - 1; i >= 0; i--) {
				var object : GameObject = gameObjects[i] as GameObject;
				if (object.checkTag(Tags.UPDATE_TAG)) {
					object.update();
				}
			}
		}
		public function destroy() :void {
			for (var i : int = gameObjects.length - 1; i >= 0; i--) {
				gameObjects[i].removeObject();
			}
			_world.removeEventListener(GameObject.ADDED, objectAdded);
			_world.removeEventListener(GameObject.REMOVED, objectRemoved);
		}
	}
}