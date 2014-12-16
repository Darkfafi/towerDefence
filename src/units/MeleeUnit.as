package units 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class MeleeUnit extends Unit 
	{
		
		public function MeleeUnit() 
		{
			super();
			
		}
		override protected function whenTargetInViewRange():void 
		{
			super.whenTargetInViewRange();
			 if (targetUnit.moving && targetUnit.targetUnit == this as Unit) {
				_moving = false;
			}else {
				_moving = true;
			}
			 calculateWaypoints(new Point(targetUnit.x, targetUnit.y));
			 
			 //Als hij dichtbij is dan val aan.
		}
	}

}