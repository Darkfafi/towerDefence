package units 
{
	import units.Unit;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class RangeUnit extends Unit 
	{
		protected var shootDelay : int;
		private var _dmgFrame : int = 4;
		
		public function RangeUnit() 
		{
			super();
			
		}
		override protected function whenTargetInViewRange():void 
		{
			super.whenTargetInViewRange();
			if (animations[DEATH_ANIM].visible != true && animations[ATTACK_ANIM].visible == false) {
				_moving = false;
				switchAnim(ATTACK_ANIM, 1);
			}
		}
		override protected function animationFrameUp():void 
		{
			super.animationFrameUp();
			if(animations[ATTACK_ANIM].visible == true){
				if(targetUnit != null){
					if (currentMovieClip.currentFrame == _dmgFrame) {
						targetUnit.takeDamage(attackDmg);
					}
				}
				if (currentMovieClip.currentFrame == currentMovieClip.totalFrames) {
					switchAnim(WALK_ANIM);
				}
			}
		}
	}
}