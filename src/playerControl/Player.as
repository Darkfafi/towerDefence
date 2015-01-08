package playerControl 
{
	import events.BuyEvent;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import gameControlEngine.GameObject;
	import gameControlEngine.Tags;
	import levels.TileSystem;
	import towers.antiGroundTowers.CanonTower;
	import towers.Tower;
	import UI.buttons.BuyButton;
	import UI.buyScreens.BuyMenu;
	import UI.ConstructMenu;
	import units.alies.BuildUnit;
	import units.Unit;
	import utils.Vector2D;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Player 
	{
		private var playerBase : PlayerBase;
		
		private var clickedObject : GameObject;
		private var plannedTowerBuild : Tower = new CanonTower();
		
		private var buildModus : Boolean = false;
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
				if(world.contains(buildTile)){
					world.removeChild(buildTile);
				}
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
			
			//checks if clicked object is a buy button
			else if (e.target.parent is BuyButton) {
				var button : BuyButton = e.target.parent as BuyButton;
				if (button.boughtItem is Tower) {
					var boughtTower : Tower = button.boughtItem as Tower;
					//show info always and go in construct mode if you have the moneys
					consructMod(boughtTower);
					trace("Show tower cost : " + boughtTower.costTower);
				}else if (button.boughtItem is Unit) {
					//place unit mod thingy
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
		
		public function addGoldToPlayer(goldAmount : int) :void {
			playerBase.addGoldToPlayer(goldAmount);
		}
		
		public function getGoldAmount() :int {
			return playerBase.gold;
		}
		public function setGoldAmount(goldAmount : int) :void {
			playerBase.gold = goldAmount;
		}
	}
}