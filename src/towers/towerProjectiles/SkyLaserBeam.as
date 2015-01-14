package towers.towerProjectiles 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import units.Unit;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class SkyLaserBeam extends Projectile 
	{
		private var explosionRadius : int;
		
		public function SkyLaserBeam(bulletDamage:int, bulletSpeed:int, bulletTarget:Unit,explRadius : int = 40) 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			super(bulletDamage, bulletSpeed, bulletTarget);
			
			explosionRadius = explRadius;
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			if (target != null) {
				x = target.x;
				y = target.y;
			}
			playAnim(art);
		}
		override public function setArt(artProjectile:Class):void 
		{
			super.setArt(artProjectile);
			art.stop();
		}
		override protected function animationFrameUp():void 
		{
			super.animationFrameUp();
			if (currentMovieClip.currentFrame == currentMovieClip.totalFrames / 2) {
				explode();
			}
		}
		override protected function AnimationFinishedPlaying():void 
		{
			super.AnimationFinishedPlaying();
			
			removeObject();
		}
		
		private function explode():void 
		{
			var explosion : Explosion = new Explosion(CanonBallExpl1Anim, explosionRadius, damage);
			
			explosion.visible = false;
			
			explosion.x = x;
			explosion.y = y;
			
			parent.addChild(explosion);
		}
	}
}