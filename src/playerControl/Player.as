package playerControl 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import gameControlEngine.GameObject;
	import gameControlEngine.Tags;
	import levels.TileSystem;
	import towers.antiGroundTowers.CanonTower;
	import towers.Tower;
	import units.alies.BuildUnit;
	import utils.Vector2D;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Player 
	{
		private var _gold : int;
		
		private var clickedObject : GameObject;
		private var plannedTowerBuild : Tower = new CanonTower();
		private var buildModus : Boolean = true;
		
		private var world : DisplayObjectContainer;
		
		public function Player(_world : DisplayObjectContainer) 
		{
			world = _world;
			world.addEventListener(MouseEvent.MOUSE_OVER, mouseHover);
			world.addEventListener(MouseEvent.MOUSE_OUT, mouseExit);
			world.addEventListener(MouseEvent.CLICK, clicked);
		}
		private function mouseHover(e:MouseEvent):void 
		{
			//info over tower in hud ofzo.
			if (buildModus) {
				if (e.target is Tile) {
					var tile : Tile = e.target as Tile;
					if (TileSystem.getTileInt(e.target.x,e.target.y) == 1) {
						tile.positiveTile(); //shows green tile
						
					}else {
						tile.negativeTile(); //shows red tile
					}
				}
			}
		}
		private function mouseExit(e:MouseEvent):void 
		{
			if (e.target is Tile) {
				var tile : Tile = e.target as Tile;
				tile.defaultTile(); // sets tile back to normal.
			}
		}
		
		private function clicked(e:MouseEvent):void 
		{
			if (clickedObject != null && clickedObject != e.target.parent) {
				clickedObject.exitInteraction();
				clickedObject = null;
			}
			//if in buildModes and you click on a buildable tile then build a tower there.
			if(buildModus){
				if(TileSystem.getTileInt(e.target.x,e.target.y) == 1){
					buildTower(e.target.x, e.target.y);
				}
				buildModus = false; // haalt je uit bouwmodus na bouwen of na random clicken.
			}
			//checks if clicked object is interactive
			else if (e.target is Sprite) {
				if(e.target.parent is GameObject){
					var gameObject : GameObject = e.target.parent as GameObject;
					if (gameObject.checkTag(Tags.INTERACTIVE_TAG)) {
						gameObject.onInteraction();
						clickedObject = gameObject;
					}
				}
			}
		}
		
		//if you click on a tower to construct from the build menu then you go to buildmodus.
		private function consructMod(clickedTower : Tower) :void {
			buildModus = true;
			plannedTowerBuild = clickedTower;
			
		}
		//sets a tower and creates a builder
		private function buildTower(xPos : int, yPos : int):void 
		{
			TileSystem.setTileInt(xPos, yPos, 0);
			var newTower : Tower = plannedTowerBuild;
			newTower.x = xPos + TileSystem.globalTile.width / 2;
			newTower.y = yPos + TileSystem.globalTile.height; 
			world.addChild(newTower);
			
			var buildUnit : BuildUnit = new BuildUnit(newTower);
			buildUnit.y = (TileSystem.globalTile.height * 6) - 25;  // moet verandert worden.
			buildUnit.setDestination(xPos, yPos);
			world.addChild(buildUnit); // misschien met een unit factory die ze goed spawned.
		}
		
	}
}