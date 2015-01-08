package playerControl 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
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
		private var playerBase : PlayerBase;
		private var _gold : int;
		
		private var clickedObject : GameObject;
		private var plannedTowerBuild : Tower = new CanonTower();
		
		private var buildModus : Boolean = true;
		private var buildTile : Tile = new Tile();
		
		private var world : DisplayObjectContainer;
		
		public function Player(_world : DisplayObjectContainer) 
		{
			world = _world;
			playerBase = TileSystem.getPlayerBase();
			world.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			world.addEventListener(MouseEvent.CLICK, clicked);
		}
		private function mouseMove(e:MouseEvent):void 
		{
			//info over tower in hud ofzo.
			if (buildModus) {
					var tile : Tile = TileSystem.getTileFromPos(new Vector2D(world.mouseX, world.mouseY));
					buildTile.x = tile.x;
					buildTile.y = tile.y;
					world.addChild(buildTile);
					
					if (TileSystem.getTileInt(tile.x,tile.y) == 1) {
						buildTile.positiveTile();
					}else {
						buildTile.negativeTile(); //shows red tile
					}
			}
		}
		
		private function clicked(e:MouseEvent):void 
		{
			if (clickedObject != null && clickedObject != e.target.parent) {
				clickedObject.exitInteraction();
				clickedObject = null;
			}
			//if in buildModes and you click on a buildable tile then build a tower there.
			if (buildModus) {
				var tile : Tile = TileSystem.getTileFromPos(new Vector2D(world.mouseX, world.mouseY));
				if(TileSystem.getTileInt(tile.x,tile.y) == 1){
					buildTower(tile.x, tile.y);
				}
				buildModus = false; // haalt je uit bouwmodus na bouwen of na random clicken.
				world.removeChild(buildTile);
			}
			//checks if clicked object is interactive
			else if (e.target is MovieClip) {
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
			var newTower : Tower = new CanonTower();
			newTower.x = xPos + TileSystem.globalTile.width / 2;
			newTower.y = yPos + TileSystem.globalTile.height; 
			world.addChild(newTower);
			plannedTowerBuild = null;
			
			playerBase.buildConstructUnit(newTower);
		}
		
	}
}