package levels 
{
	import events.HudEvent;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import levels.levelList.Level1;
	import screens.GameScreen;
	import screens.ScreenManager;
	import UI.UiGlobalInfo;
	import units.enemies.groundUnits.EnemyClawRobot;
	import units.Unit;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class LevelPlacer extends Sprite
	{
		private var tileSystem : TileSystem
		
		private var currentLevel : int;
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
		public function createLevel(levelInt : int) :Level {				
			tileSystem.placeTiles(allLevelsList[levelInt].levelGrid);
			currentLevel = levelInt;
			var hudEvent : HudEvent = new HudEvent(UiGlobalInfo.GLOBAL_UI_INFO, UiGlobalInfo.LEVEL_INFO,String(currentLevel + 1), true);
			dispatchEvent(hudEvent);
			allLevelsList[levelInt].levelId = levelInt;
			
			return allLevelsList[levelInt];
		}
		public function destroy() :void {
			var level : Level = allLevelsList[currentLevel] as Level;
			level.destroy();
		}
		
		public function checkIfCanBePlaced(lvlInt : int):Boolean 
		{
			var result : Boolean = false;
			if (allLevelsList[lvlInt] != null) {
				result = true;
			}
			return result;
		}
	}
}