package towers.towerProjectiles 
{
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
			art.graphics.clear();
			art = new ElectricBeam();
			addChild(art);
			art.stop();
			
			var diffX : Number = target.x - this.x;
			var diffY : Number = target.y - this.y;
			
			trace(new Vector2D(diffX, diffY).length +" <-- length | X diff -->" + diffX);
			
			art.scaleX = ((1 / art.width) * Math.abs(new Vector2D(diffX, diffY).length)) * 0.1;
			var rotInRad : Number = Math.atan2(diffY, diffX);
			
			art.rotation = (rotInRad * (180 / Math.PI));
			
			
			playAnim(art);
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