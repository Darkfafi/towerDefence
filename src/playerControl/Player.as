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
					//trace(TileSystem.hitTileInt(new Vector2D(tile.x, tile.y)));
					if (TileSystem.getTileInt(e.target.x,e.target.y) == 1) { //of als plannedTowerBuild.baseTileSize gits tile non 1.
						tile.positiveTile();
						
					}else {
						tile.negativeTile();
					}
				}
			}
		}
		private function mouseExit(e:MouseEvent):void 
		{
			if (e.target is Tile) {
				var tile : Tile = e.target as Tile;
				tile.defaultTile();
			}
		}
		
		private function clicked(e:MouseEvent):void 
		{
			//zet plannedTowerBuild naar toren waar op gedrukt is.
			var tile : Tile;
			if(buildModus){
				if(TileSystem.getTileInt(e.target.x,e.target.y) == 1){
					buildTower(e.target.x, e.target.y);
				}
				buildModus = false; // haalt je uit bouwmodus na bouwen of na random clicken.
			}else if (e.target is Sprite) {
				if(e.target.parent is Tower){
					var gameObject : GameObject = e.target.parent as GameObject;
					if (gameObject.checkTag(Tags.INTERACTIVE_TAG)) {
						trace("trace");
						gameObject.onInteraction();
					}
				}
			}else if (e.target is Tile) {
				tile = e.target as Tile;
				if (TileSystem.getTileInt(e.target.x, e.target.y) == 2) {
					//move unit to mouseX && mouseY. (makes unit(buys them) and places them on a locked location).
				}
			}
		}
		
		private function consructMod(clickedTower : Tower) :void {
			buildModus = true;
			plannedTowerBuild = clickedTower;
			
		}
		private function buildTower(xPos : int, yPos : int):void 
		{
			TileSystem.setTileInt(xPos, yPos, 0); // <== test. zet bij function build tower ofzo
			var newTower : Tower = plannedTowerBuild;
			newTower.x = xPos + TileSystem.globalTile.width / 2;
			newTower.y = yPos + TileSystem.globalTile.height; 
			world.addChild(newTower);
			
			var buildUnit : BuildUnit = new BuildUnit(newTower);
			buildUnit.y = (TileSystem.globalTile.height * 6) - 25;  // moet verandert worden.
			buildUnit.setDestination(xPos, yPos);
			world.addChild(buildUnit);
			//place plannedTowerBuild.baseTileSize on position and add tower.
		}
		
	}
}