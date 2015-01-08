package playerControl 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.geom.Point;
	import gameControlEngine.GameObject;
	import gameControlEngine.Tags;
	import levels.TileSystem;
	import towers.Tower;
	import units.alies.BuildUnit;
	import units.enemies.groundUnits.EnemyUnit;
	import units.Unit;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class PlayerBase extends GameObject
	{
		private var _lives : int = 15;
		
		//List Of Units
		private static const BUILD_UNIT_TYPE : String = "buildUnitType";
		
		//-----
		private var world : DisplayObjectContainer;
		
		//De base is waar de enemies op af gaan en als ze er komen verlies je levens. Ook worden via de base all de allied units gemaakt en geplaatst
		public function PlayerBase(_world : DisplayObjectContainer) 
		{
			world = _world;
			drawBase(); 
		}
		
		public function loseLife(dmg : int):void 
		{
			_lives -= dmg;
			if (_lives <= 0) {
				_lives = 0;
				trace("GAME LOST. GO TO MENU!");
			}
		}
		
		public function buildUnit(unitType : String,destination : Point):Unit 
		{
			var unit : Unit;
			switch(unitType) {
				case BUILD_UNIT_TYPE :
					unit = new BuildUnit();
				break;
			}
			unit.x = x + width / 2;
			unit.y = y + height / 2;
			unit.setDestination(destination.x,destination.y);
			unit.calculateWaypoints(destination);
			world.addChild(unit);
			return unit;
		}
		
		public function buildConstructUnit(towerToBuild : Tower):void
		{
			var buildUnit : BuildUnit = buildUnit(BUILD_UNIT_TYPE, new Point(towerToBuild.x - TileSystem.globalTile.width / 2, towerToBuild.y  - TileSystem.globalTile.height / 2)) as BuildUnit;
			buildUnit.setTowerTarget(towerToBuild);
		}
		
		private function drawBase():void 
		{
			graphics.beginFill(0xffff00);
			graphics.drawRect(0, 0, 67, 50);
			graphics.endFill();
		}
	}
}