package levels.levelList 
{
	import levels.Level;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Level1 extends Level 
	{
		
		public function Level1() 
		{
			super();
		}
		override protected function setLevelInfo():void 
		{
			_levelGrid = [
				[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
				[0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0],
				[0, 0, 0, 0, 0, 0, 1, 2, 2, 2, 2, 1],
				[0, 0, 0, 0, 0, 1, 2, 2, 1, 1, 2, 1],
				[1, 1, 1, 1, 1, 2, 2, 1, 0, 1, 2, 4],
				[3, 2, 2, 2, 2, 2, 1, 0, 0, 0, 1, 1],
				[1, 1, 1, 1, 1, 2, 2, 1, 1, 1, 2, 4],
				[0, 0, 0, 0, 0, 1, 2, 2, 2, 2, 2, 1],
				[0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0],
				[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
				[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
				[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
			];
		}
		override protected function setSpawnInfo():void 
		{
			super.setSpawnInfo();
		}
		
	}

}