package units.enemies
{
	import units.Unit;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class EnemyUnit extends Unit
	{
		
		public function EnemyUnit() 
		{
			
		}
		override protected function drawUnit():void 
		{
			art.graphics.beginFill(0xFF0000, 1);
			art.graphics.drawRect(-10, -30, 20,30);
			art.graphics.endFill();
			addChild(art);
		}
	}

}