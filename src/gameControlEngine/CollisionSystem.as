package gameControlEngine 
{
	import flash.display.DisplayObjectContainer;
	import gameControlEngine.GameObject;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class CollisionSystem 
	{
		private var allObjects : Array = [];
		public function checkCollision(listObjects : Array, world : DisplayObjectContainer) :void {
			allObjects = listObjects;
			var l : int = listObjects.length;
			for (var i : int = l - 1; i >= 0; i--) {
				//collision system
				var currentObj : GameObject = listObjects[i] as GameObject;
				if(currentObj && currentObj.checkTag(Tags.COLLIDER_TAG)){
					for (var j : int = l - 1; j >= 0; j--) {
						var other : GameObject = listObjects[j] as GameObject;
						if(other){
							if (other.checkTag(Tags.COLLIDER_TAG) && other != currentObj) {
								if (currentObj.willCollide(other) && currentObj.checkCollidingWithObject(other) == false) {
									currentObj.onCollisionEnter(other);
								}else if (currentObj.willCollide(other)) {
									currentObj.onCollision(other);
								}else if(currentObj.checkCollidingWithObject(other)) {
									currentObj.onCollisionExit(other);
								}
							}
						}
					}
				}
			}
		}
		
		public function checkDeletedObjInCollision(deletedObj : GameObject):void 
		{
			var l : int = allObjects.length;
			for (var i : int = l - 1; i >= 0; i--) {
				var gameObj : GameObject = allObjects[i] as GameObject;
				if(gameObj.checkTag(Tags.COLLIDER_TAG)){
					if (gameObj.checkCollidingWithObject(deletedObj)) {
						gameObj.onCollisionExit(deletedObj);
					}
				}
			}
		}
	}

}