package towers.towerProjectiles 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import gameControlEngine.gameExtraClasses.WatchingObject;
	import gameControlEngine.GameObject;
	import gameControlEngine.Tags;
	import units.enemies.groundUnits.EnemyUnit;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Explosion extends WatchingObject 
	{
		private var _damage : int;
		private var _explosionArt : MovieClip;
		private var _explosionRange : int;
		
		public function Explosion(explosionArt : Class,explosionRange : int, damage : int) 
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, init);
			
			addTag(Tags.UPDATE_TAG);
			addTag(Tags.POSITION_ON_TOP_TAG);
			
			_explosionArt = new explosionArt as MovieClip;
			_damage = damage;
			_explosionRange = explosionRange;
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			addChild(_explosionArt);
			_explosionArt.gotoAndStop(1);
			
			rangeView.setSeeAbleObjects([EnemyUnit]);
			
			addChild(rangeView);
			
			rangeView.drawRangeView(_explosionRange);
			
			playAnim(_explosionArt);
		}
		
		private function explosion():void 
		{
			var l : int = targetObjects.length;
			trace(targetObjects);
			for (var i : int = l - 1; i >= 0; i--) {
				if (targetObjects[i] is EnemyUnit) {
					var enemy : EnemyUnit = targetObjects[i] as EnemyUnit;
					enemy.takeDamage(_damage);
				}
			}
		}
		override protected function animationFrameUp():void 
		{
			super.animationFrameUp();
			if (currentMovieClip.currentFrame == currentMovieClip.totalFrames / 2) {
				explosion();
			}
		}
		override protected function AnimationFinishedPlaying():void 
		{
			super.AnimationFinishedPlaying();
			if (currentMovieClip == _explosionArt) {
				removeObject();
			}
		}
		
	}

}