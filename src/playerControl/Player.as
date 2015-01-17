package playerControl 
{
	import events.BuyEvent;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import gameControlEngine.GameObject;
	import gameControlEngine.Tags;
	import levels.TileSystem;
	import media.SoundManager;
	import towers.antiGroundTowers.CanonTower;
	import towers.Tower;
	import UI.buttons.BuyButton;
	import UI.buyScreens.BuyMenu;
	import UI.buyScreens.PriceBar;
	import UI.ConstructMenu;
	import UI.InfoMenu;
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
		
		private var plannedTowerBuild : Tower = new Tower();
		private var plannedUnitDeploy : Unit = new Unit();
		
		private var buildModus : Boolean = false;
		
		private var priceBar : PriceBar;
		
		private var buildTile : Tile = new Tile();
		
		private var buildIntArray : Array = []; //is een lijst met ints waar gebouwd kan worden
		
		private var world : DisplayObjectContainer;
		
		public function Player(_world : DisplayObjectContainer) 
		{
			world = _world;
			playerBase = TileSystem.getPlayerBase();
			priceBar = new PriceBar();
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
					
					if (checkBuildable(TileSystem.getTileInt(tile.x,tile.y))) {
						buildTile.positiveTile();
					}else {
						buildTile.negativeTile(); //shows red tile
					}
			}else if (e.target.parent is BuyButton) {
				if(priceBar.priceBarArt() == false){
					var button : BuyButton = e.target.parent as BuyButton;
					if (button.boughtItem is Tower) {
						var boughtTower : Tower = button.boughtItem as Tower;
						priceBar.showCost(boughtTower.costTower);
					}else if (button.boughtItem is Unit) {
						var boughtUnit : Unit = button.boughtItem as Unit;
						priceBar.showCost(boughtUnit.costUnit);
						
						//was bezig met unit placement. Ook worden builders via unbuild towers aangeraden als hun builder dood is.
					}
					world.addChild(priceBar);
				}else if (priceBar.priceBarArt()) {
					if (e.target.hitTestPoint(priceBar.x, priceBar.y) == false) {
						world.removeChild(priceBar);
						priceBar.hide();
					}
				}
			}else {
				if (priceBar.priceBarArt()) {
					world.removeChild(priceBar);
					priceBar.hide();
				}
			}
			priceBar.x = world.mouseX + 5;
			priceBar.y = world.mouseY;
		}
		
		private function clicked(e:MouseEvent):void 
		{
			if (clickedObject != null && clickedObject != e.target.parent && e.target.parent is InfoMenu == false) {
				clickedObject.exitInteraction();
				clickedObject = null;
			}
			//if in buildModes and you click on a buildable tile then build a tower there.
			if (buildModus) {
				var tile : Tile = TileSystem.getTileFromPos(new Vector2D(world.mouseX, world.mouseY));
				if (checkBuildable(TileSystem.getTileInt(tile.x, tile.y))) {
					if(checkBuildable(1)){
						buildTower(tile.x, tile.y);
					}else {
						deployUnit(tile.x + tile.width / 2,tile.y + tile.height / 2);
					}
				}
				buildIntArray = [];
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
					if(playerBase.gold >= boughtTower.costTower){
						consructMod(boughtTower);
					}
				}else if (button.boughtItem is Unit) {
					var boughtUnit : Unit = button.boughtItem as Unit;
					if (playerBase.gold >= boughtUnit.costUnit) {
						deployMod(boughtUnit);
					}
				}
			}
			if (e.target is SimpleButton) {
				SoundManager.playSound(SoundManager.BUTTON_SOUND);
			}
		}
		
		private function deployUnit(posX:int, posY:int):void 
		{
			TileSystem.setTileInt(posX, posY, 6);
			var newUnit : Unit = plannedUnitDeploy;
			playerBase.buildUnit(newUnit, new Point(posX, posY));
			plannedUnitDeploy = null;
			addGoldToPlayer(-newUnit.costUnit);
		}
		
		//if you click on a tower to construct from the build menu then you go to buildmodus.
		private function consructMod(clickedTower : Tower) :void {
			buildModus = true;
			buildIntArray = [1];
			plannedTowerBuild = clickedTower;
			
		}
		private function deployMod(boughtUnit:Unit):void {
			buildModus = true;
			buildIntArray = [2];
			plannedUnitDeploy = boughtUnit;
			
		}
		//sets a tower and creates a builder
		private function buildTower(xPos : int, yPos : int):void 
		{
			SoundManager.playSound(SoundManager.BUILDING_PLACE_SOUND);
			TileSystem.setTileInt(xPos, yPos, 5);
			var newTower : Tower = plannedTowerBuild;
			newTower.x = xPos + TileSystem.globalTile.width / 2;
			newTower.y = yPos + TileSystem.globalTile.height - 10; 
			world.addChild(newTower);
			plannedTowerBuild = null;
			addGoldToPlayer( -newTower.costTower);
			playerBase.buildConstructUnit(newTower);
		}	
		
		public function checkBuildable(tileInt : int) : Boolean {
			var result : Boolean = false;
			for (var i : int = 0; i < buildIntArray.length; i++) {
				if (buildIntArray[i] == tileInt) {
					result = true;
				}
			}
			return result;
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
		
		public function destroy():void 
		{
			world.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			world.addEventListener(MouseEvent.CLICK, clicked);
			if(priceBar.visible == false){
				priceBar.hide();
			}
		}
	}
}