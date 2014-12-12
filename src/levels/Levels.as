package levels 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import units.enemies.EnemyUnit;
	import units.Unit;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Levels extends Sprite
	{
		private var tileSystem : TileSystem
		
		public static const level1 : Array = [
			//Hier design van het level 20,20
			//misschien ok informatie over de wave system en/of background
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
		
		public function Levels() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			tileSystem = new TileSystem(parent);
			createLevel(level1);
			//----------------TEST--------------
				var unit : Unit = new EnemyUnit();
				unit.x = stage.stageWidth - TileSystem.globalTile.width / 2;
				unit.y = (5 * 50) - TileSystem.globalTile.height / 2; // moet naar midden van tile
				unit.setDestination(TileSystem.globalTile.width / 2, (6 * 50) - TileSystem.globalTile.height / 2); // moet naar midden van tile
				addChild(unit);
			//----------------------------------
		}
		public function createLevel(level : Array) :void {
			tileSystem.placeTiles(level);
		}
		
	}

}