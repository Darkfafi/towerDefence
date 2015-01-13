package units.enemies.groundUnits 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class EnemyMeleeUnit extends EnemyUnit 
	{
		protected var _dmgFrame : int = 2;
		
		public function EnemyMeleeUnit() 
		{
			super();
			
		}
		override protected function whenTargetInViewRange():void 
		{
			super.whenTargetInViewRange();
			if(animations[DEATH_ANIM].visible != true){
				if (targetUnit.moving && targetUnit.targetUnit == this as EnemyMeleeUnit /*en type is niet ranged...Anders kan je best lang wachten*/) {
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