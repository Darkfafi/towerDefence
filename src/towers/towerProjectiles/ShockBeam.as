package towers.towerProjectiles 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import units.Unit;
	import utils.Vector2D;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class ShockBeam extends Projectile 
	{
		
		public function ShockBeam(bulletDamage:int, bulletSpeed:int, bulletTarget:Unit) 
		{
			super(bulletDamage, bulletSpeed, bulletTarget);
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			var diffX : Number = target.x - this.x;
			var diffY : Number = target.y - this.y;
			
			art.gotoAndStop(art.totalFrames);
			
			art.scaleX = ((1 / art.width) * Math.abs(new Vector2D(diffX, diffY).length) * 1);
			var rotInRad : Number = Math.atan2(diffY, diffX);
			
			art.rotation = (rotInRad * (180 / Math.PI));
			
			art.gotoAndStop(1);
			
			playAnim(art,60 / art.scaleX);
		}
		override public function setArt(artProjectile:Class):void 
		{
			super.setArt(artProjectile);
			art.stop();
		}
		override protected function AnimationFinishedPlaying():void 
		{
			super.AnimationFinishedPlaying();
			if(target != null){
				target.takeDamage(damage);
			}
			removeObject();
		}
		
	}

}