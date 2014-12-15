package playerControl 
{
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	import gameControlEngine.GameObject;
	import levels.TileSystem;
	import towers.Tower;
	import units.alies.BuildUnit;
	import units.Unit;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class PlayerBase extends GameObject
	{
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
			world.addChild(unit);
			unit.calculateWaypoints(destination);
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