package gameControlEngine 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class GameObject extends Sprite
	{
		private var removing : Boolean = false;
		
		public var collidedObject : GameObject;
		
		public var colliding : Boolean = false;
		
		private var tags : Array = [];
		
		public function GameObject() 
		{
			
		}
		
		public function willCollide(other : GameObject) : Boolean {
			var result : Boolean = false;
			if (this.hitTestObject(other)) {
				result = true;
			}
			return result;
		}
		
		public function onCollisionEnter(other : GameObject):void {
			colliding = true;
		}
		
		public function onCollision(other : GameObject) :void {
			collidedObject = other;
		}
		
		public function onCollisionExit(other : GameObject):void {
			colliding = false;
			collidedObject = null;
		}
		
		public function onInteraction() :void {
			
		}
		public function removeObject():void {
			if (!removing) {
				removing = true;
				removeTag(Tags.COLLIDER_TAG);
				parent.removeChild(this);
			}
		}
		//---------------tag system------------------
		/**
		 * @param	_tag
		 * You can use this function to add tags from the Class 'Tags'.
		 */
		public function addTag(_tag : String):void {
			tags.push(_tag);
		}
		public function removeTag(_tag : String) :void {
			var index : int = tags.indexOf(_tag);
			tags.splice(index, 1);
		}
		public function checkTag(_tag : String) : Boolean {
			var result : Boolean = false;
			for (var i : int = 0; i < tags.length; i++) {
				if (_tag == tags[i]) {
					result = true;
					break;
				}
			}
			return result;
		}
		//------------------------------------------------
		
		public function update():void 
		{
			
		}
		
	}

}