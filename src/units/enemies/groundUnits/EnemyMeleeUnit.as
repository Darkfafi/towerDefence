package units.enemies.groundUnits 
{
	import flash.geom.Point;
	import gameControlEngine.GameObject;
	import units.RangeUnit;
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
				if (targetUnit.moving && targetUnit.targetUnit == this as EnemyMeleeUnit && targetUnit is RangeUnit == false) {
					_moving = false;
				}else if(animations[ATTACK_ANIM].visible == false) {
					_moving = true;
				}
				calculateWaypoints(new Point(targetUnit.x, targetUnit.y));
			}	
		}
		override public function onCollision(other:GameObject):void 
		{
			super.onCollision(other);
			if(other == targetUnit){
				if(animations[ATTACK_ANIM].visible == false && animations[DEATH_ANIM].visible == false) {
					_moving = false;
					switchAnim(ATTACK_ANIM, 1);
				}
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
			}
		}
		override protected function AnimationFinishedPlaying():void 
		{
			if (animations[ATTACK_ANIM].visible == true) {
				switchAnim(WALK_ANIM);
				
				calculateWaypoints(destination);
			}
			super.AnimationFinishedPlaying();
		}
	}
}