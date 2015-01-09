package gameControlEngine 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import levels.TileSystem;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class GameObject extends Sprite
	{
		public static const ADDED : String = "addedGameOb";
		public static const REMOVED : String = "removedGameOb";
		
		protected var removing : Boolean = false;
		
		public var collidingObjects : Array = [];
		
		private var hitBox : Sprite = new Sprite();
		
		private var tags : Array = [];
		
		//animation variables
		protected var currentMovieClip : MovieClip;
		protected var defaultFps : int = 30;
		protected var framesAnim : Timer;
		
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
			//hitBox.graphics.beginFill(0x000000, 0.5);
			hitBox.graphics.drawRect(xPos, yPos, hitWidth, hitHeight);
			//hitBox.graphics.endFill();
			addChild(hitBox);
		}
		
		public function onCollisionEnter(other : GameObject):void {
			collidingObjects.push(other);
		}
		
		public function onCollision(other : GameObject) :void {
			
		}
		
		public function onCollisionExit(other : GameObject):void {
			collidingObjects.splice(collidingObjects.indexOf(other), 1);
		}
		
		public function checkCollidingWithObject(object : GameObject) :Boolean {
			var result : Boolean = false;
			for (var i : int = 0; i < collidingObjects.length; i++) {
				if (object == collidingObjects[i]) {
					result = true;
					break;
				}
			}
			return result;
		}
		public function onInteraction() :void {
			
		}
		public function exitInteraction() :void {
			
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
			if(framesAnim != null){
				framesAnim.removeEventListener(TimerEvent.TIMER, playingAnimaion);
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
		
		//------------Animation Section------------------
		protected function playAnim(movieClip : MovieClip,fpsAnim : Number = 30):void 
		{
			var fps : Number = 1000 / fpsAnim;
			framesAnim = new Timer(fps);
			currentMovieClip = movieClip;
			movieClip.gotoAndStop(1);
			framesAnim.addEventListener(TimerEvent.TIMER, playingAnimaion);
			framesAnim.start();
		}
		protected function playingAnimaion(t : TimerEvent) :void {
			
			
			animationFrameUp();
			
			if (currentMovieClip.currentFrame == currentMovieClip.totalFrames) {
				
				AnimationFinishedPlaying();
			}
		}
		
		protected function animationFrameUp():void 
		{
			currentMovieClip.gotoAndStop(currentMovieClip.currentFrame + 1);
		}
		
		protected function AnimationFinishedPlaying():void 
		{
			framesAnim.removeEventListener(TimerEvent.TIMER, playingAnimaion);
			framesAnim.reset();
		}
		//---------------------------------------------
		
		public function update():void 
		{
			
		}
		
	}

}