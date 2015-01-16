package playerControl 
{
	import events.HudEvent;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import gameControlEngine.GameObject;
	import gameControlEngine.Tags;
	import levels.TileSystem;
	import towers.Tower;
	import UI.UiGlobalInfo;
	import units.alies.BuildUnit;
	import units.enemies.groundUnits.EnemyUnit;
	import units.Unit;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class PlayerBase extends GameObject
	{
		public static const NO_MORE_LIVES : String = "noMoreLives";
		
		private var _backArtBase : Sprite = new CommandCenterBackArt();
		private var _frontArtBase : GameObject = new PlayerBaseArt();
		
		//stats playerBase
		private var _gold : int; //word gegeven door level aan begin en later gevult door kills en stuff
		private var _lives : int = 1;
		
		private var world : DisplayObjectContainer;
		
		//De base is waar de enemies op af gaan en als ze er komen verlies je levens. Ook worden via de base all de allied units gemaakt en geplaatst
		public function PlayerBase(_world : DisplayObjectContainer) 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			world = _world;
			drawBase(); 
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			sendHudData(UiGlobalInfo.LIVES_INFO, _lives.toString());
			
			world.addChild(_backArtBase);
			world.addChild(_frontArtBase);
			
			_frontArtBase.y = _backArtBase.y = y + TileSystem.globalTile.height + 10;
		}
		
		public function loseLife(dmg : int):void 
		{
			_lives -= dmg;
			sendHudData(UiGlobalInfo.LIVES_INFO, _lives.toString());
			if (_lives <= 0) {
				_lives = 0;
				trace("GAME LOST. GO TO MENU!");
				dispatchEvent(new Event(NO_MORE_LIVES,true));
			}
		}
		
		public function buildUnit(unitType : Unit,destination : Point):Unit 
		{
			var unit : Unit;
			unit = unitType;
			unit.x = x + width / 2;
			unit.y = y + height / 2;
			unit.setDestination(destination.x,destination.y);
			unit.calculateWaypoints(destination);
			world.addChild(unit);
			return unit;
		}
		
		public function buildConstructUnit(towerToBuild : Tower):void
		{
			var builder : Unit = new BuildUnit();
			
			var buildUnit : BuildUnit = buildUnit(builder, new Point(towerToBuild.x - TileSystem.globalTile.width / 2, towerToBuild.y  - TileSystem.globalTile.height / 2)) as BuildUnit;
			buildUnit.setTowerTarget(towerToBuild);
		}
		
		private function drawBase():void 
		{
			graphics.beginFill(0xffff00);
			graphics.drawRect(0, 0, 67, 50);
			graphics.endFill();
		}
		
		public function addGoldToPlayer(goldAmount : int) :void {
			gold += goldAmount;
		}
		
		public function get gold():int 
		{
			return _gold;
		}
		
		public function set gold(value:int):void 
		{
			_gold = value;
			sendHudData(UiGlobalInfo.GOLD_INFO, _gold.toString());
		}
		private function sendHudData(type : String, data : String) :void {
			var hudEvent : HudEvent = new HudEvent(UiGlobalInfo.GLOBAL_UI_INFO, type, data, true);
			dispatchEvent(hudEvent);
			
		}
	}
}