package gameControlEngine 
{
	import flash.display.DisplayObjectContainer;
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
			_world.addEventListener(Event.ADDED_TO_STAGE, objectAdded, true);
			_world.addEventListener(Event.REMOVED_FROM_STAGE, objectRemoved, true);
		}
		
		private function objectRemoved(e:Event):void 
		{
			if (e.target is GameObject) {
				var object : GameObject = e.target as GameObject;
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
			collisionSystem.checkCollision(gameObjects,_world);
			var l : int = gameObjects.length;
			for (var i : int = l - 1; i >= 0; i--) {
				var object : GameObject = gameObjects[i] as GameObject;
				if (object.checkTag(Tags.UPDATE_TAG)) {
					object.update();
				}
			}
		}
	}
}