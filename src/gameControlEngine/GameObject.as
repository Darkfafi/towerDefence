package gameControlEngine 
{
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class GameObject extends Sprite
	{
		public static const ADDED : String = "addedGameOb";
		public static const REMOVED : String = "removedGameOb";
		
		private var removing : Boolean = false;
		
		public var collidedObject : GameObject;
		
		public var colliding : Boolean = false;
		
		private var hitBox : Sprite = new Sprite();
		
		private var tags : Array = [];
		
		public function GameObject() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			dispatchEvent(new Event(ADDED, true));
			drawHitBoxObjectArt();
			if(checkTag(Tags.COLLIDER_TAG)){
				setHitBox( -width / 2, - height, width, height);
			}
		}
		
		protected function drawHitBoxObjectArt():void 
		{
			
		}
		
		public function willCollide(other : GameObject) : Boolean {
			var result : Boolean = false;
			if (hitBox.hitTestObject(other.hitBox)) {
				result = true;
			}
			return result;
		}
		
		public function setHitBox(xPos : Number, yPos : Number, hitWidth : Number, hitHeight : Number) :void {	
			
			if (contains(hitBox)) {
				removeChild(hitBox);
			}
			hitBox.graphics.clear();
			hitBox.graphics.beginFill(0x000000, 0.5);
			hitBox.graphics.drawRect(xPos, yPos, hitWidth, hitHeight);
			hitBox.graphics.endFill();
			addChild(hitBox);
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
				destroy();
				dispatchEvent(new Event(REMOVED,true));
				tags = [];
				parent.removeChild(this);
			}
		}
		
		public function destroy() :void {
			
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