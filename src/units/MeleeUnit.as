package units 
{
	import flash.geom.Point;
	import units.enemies.groundUnits.EnemyMeleeUnit;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class MeleeUnit extends Unit 
	{
		protected var _dmgFrame : int = 2;
		
		public function MeleeUnit() 
		{
			super();
			
		}
		override protected function whenTargetInViewRange():void 
		{
			super.whenTargetInViewRange();
			if(animations[DEATH_ANIM].visible != true){
				if (targetUnit.moving && targetUnit.targetUnit == this as MeleeUnit /*en type is niet ranged...Anders kan je best lang wachten*/) {
					_moving = false;
				}else if(animations[ATTACK_ANIM].visible == false) {
					_moving = true;
				}
				calculateWaypoints(new Point(targetUnit.x, targetUnit.y));
				 
				if (this.x - targetUnit.x < 1 && this.y - targetUnit.y < 1 && animations[ATTACK_ANIM].visible == false) {
					_moving = false;
					switchAnim(ATTACK_ANIM, 1);
				}
			}
		}
		override protected function animationFrameUp():void 
		{
			super.animationFrameUp();
			if(currentMovieClip == animations[ATTACK_ANIM]){
				if(targetUnit != null){
					if (currentMovieClip.currentFrame == _dmgFrame) {
						targetUnit.takeDamage(attackDmg);
					}
				}
			}
		}
		override protected function AnimationFinishedPlaying():void 
		{
			if (animations[ATTACK_ANIM].visible == true) {
				switchAnim(WALK_ANIM);
			}
			super.AnimationFinishedPlaying();
		}
	}	
}