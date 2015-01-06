package levels 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import levels.levelList.Level1;
	import units.enemies.groundUnits.EnemyClawRobot;
	import units.Unit;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class LevelPlacer extends Sprite
	{
		private var tileSystem : TileSystem
		
		private var allLevelsList : Array = [new Level1]; // array met alle levels
		
		private var _world : DisplayObjectContainer;
		
		public function LevelPlacer(world : DisplayObjectContainer) 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			_world = world;
			fillAllLevels();
		}
		
		private function fillAllLevels():void 
		{
			for (var i : int = 0; i < allLevelsList.length; i++) {
				var level : Level = allLevelsList[i];
				level.setWorld(_world);
				allLevelsList[i] = level;
			}
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			tileSystem = new TileSystem(parent);
		}
		public function createLevel(levelInt : int) :void {
			tileSystem.placeTiles(allLevelsList[levelInt].levelGrid);
			allLevelsList[levelInt].startLevel();
		}
		
	}

}