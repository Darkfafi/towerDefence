package towers 
{
	import events.ShowInfoEvent;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import gameControlEngine.gameExtraClasses.RangeView;
	import gameControlEngine.gameExtraClasses.WatchingObject;
	import gameControlEngine.GameObject;
	import gameControlEngine.Tags;
	import levels.TileSystem;
	import playerControl.PlayerBase;
	import UI.InfoMenu;
	import units.alies.BuildUnit;
	import units.Unit;
	import utils.Vector2D;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Tower extends WatchingObject
	{
		public static const TOWER_BUILD : String = "towerFinishedBuilding";
		
		//na het buiden van de tower addTag de update tag om het ook zijn functie te laten doen.
		
		//target
		protected var currentTarget : Unit = null;
		
		//tower base vars
		protected var baseTileSize : Sprite = new Sprite(); // <== hiermee word de toren neergezet en worden alle hittests mee uitgevoert
		
		//tower Art
		protected var currentArtInt : int; // int van allTowerArt en allFireArt die momenteel gebruikt word.
		protected var currentArtVisible : Array = []; // array van momentele art van toren
		
		protected var towerBuildAnim : MovieClip; //deze array bevat alle construct tower art.
		protected var allTowerArt : Array = []; // deze array bevat alle tower/upgrade art.
		protected var allFireAnim : Array = []; //deze array bevat alle tower attack/fire animations
		protected var allProjectiles : Array = []; // deze array bevat alle projectile art
		
		// all bullet art dat je kan meegeven ofzo
		
		private var towerArt : MovieClip;
		private var towerFireArt : MovieClip;
		
		//tower stats
		protected var shootFrame : int = 2;
		protected var _upgradeCost : int;
		protected var _costTower : int;
		
		protected var range : Number;
		protected var fireRate : int;
		protected var bulletSpeed : int;
		protected var attackDmg : int;
		
		//
		private var needBuilderSign : SimpleButton = new BuyBuilderButton();
		
		//build tower with timer. Every timer event it changes art in building with gotoAndStop.
		public function Tower() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			
			setStats();
			
			addTag(Tags.INTERACTIVE_TAG);
			addTag(Tags.COLLIDER_TAG);
			addTag(Tags.POSITION_ON_Y_TAG);
			addTag(Tags.UPDATE_TAG);
			
			baseTileSize.graphics.beginFill(0x000000, 0);
			baseTileSize.graphics.drawRect(-TileSystem.globalTile.width / 2, TileSystem.globalTile.height, TileSystem.globalTile.width, TileSystem.globalTile.height);
			baseTileSize.graphics.endFill();
			addChild(baseTileSize);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			setHitBox(-baseTileSize.width / 2, -baseTileSize.height, baseTileSize.width, baseTileSize.height);
			
		}
		
		protected function setStats():void 
		{
			
		}
		override public function update():void 
		{
			super.update();
			if(currentTarget != targetObjects[0]){
				currentTarget = targetObjects[0]; //als er een target is dan stopt hij die er in anders is currentTarget null
				if (towerFireArt.visible == false) {
					startFire();
				}
			}
		}
		override protected function drawHitBoxObjectArt():void 
		{
			super.drawHitBoxObjectArt();
			drawTower();
		}
		
		public function towerBuildUp():void {
			if (towerBuildAnim.currentFrame != towerBuildAnim.totalFrames) {
				towerBuildAnim.gotoAndStop(towerBuildAnim.currentFrame + 1);
			}else {
				dispatchEvent(new Event(TOWER_BUILD, true));
				removeChild(towerBuildAnim);
				addRangeView();
				changeTowerArt(0);
				if (contains(needBuilderSign)) {
					removeChild(needBuilderSign);
					needBuilderSign.removeEventListener(MouseEvent.CLICK, askForBuilder);
				}
			}
		}
		protected function changeTowerArt(towerArtInt : int) :void {
			for (var i : int = currentArtVisible.length - 1; i >= 0; i--) {
				if (contains(currentArtVisible[i])) {
					removeChild(currentArtVisible[i]);
					currentArtVisible.splice(i, 1);
				}
			}
			
			currentArtInt = towerArtInt;
			
			towerArt = allTowerArt[currentArtInt];
			towerFireArt = allFireAnim[currentArtInt];
			
			currentArtVisible.push(towerArt, towerFireArt);
			
			addChild(towerArt); // geeft error als je voorbij de array limit gaat.
			addChild(towerFireArt); // ^
			
			towerFireArt.stop();
			towerFireArt.visible = false;
			
		}
		private function addRangeView():void 
		{
			addChild(rangeView);
			rangeView.y -= baseTileSize.height / 2;
			changeRange(range);
		}
		
		protected function changeRange(_range : int) :void {
			range = _range;
			rangeView.drawRangeView(range);
		}
		
		protected function drawTower():void 
		{
			removeChild(baseTileSize);
			towerBuildAnim.gotoAndStop(1);
			addChild(towerBuildAnim);
		}
		public function upgrade() :void {
			if(contains(towerBuildAnim) == false && allTowerArt[currentArtInt + 1] is MovieClip){
				//als er een volgende upgrade is anders 99999 dat vertaald word in hud als max upgrade
				if(allTowerArt[currentArtInt + 2] is MovieClip){
					_upgradeCost += (_upgradeCost * (currentArtInt + 2)) / 2;
				}else {
					_upgradeCost = 00;
				}
				changeTowerArt(currentArtInt + 1);
			}else if(contains(towerBuildAnim)) {
				trace("Can't upgrade unfinished tower");
			}else {
				trace("Max upgrades");
			}
			dispatchEvent(new Event(InfoMenu.CLOSE_INFO, true));
		}
		
		public function sell() :void {
			if(contains(towerBuildAnim) == false){
				var playerBase : PlayerBase = TileSystem.getPlayerBase();
				playerBase.addGoldToPlayer((_costTower + (currentArtInt * (_upgradeCost/2))) / 2);
				var tile : Tile = TileSystem.getTileFromPos(new Vector2D(x, y));
				TileSystem.setTileInt(tile.x,tile.y, 1);
				removeObject();
			}
		}
		
		override public function onInteraction():void 
		{
			super.onInteraction();
			
			rangeView.setAlpha(0.4);
			var event : ShowInfoEvent = new ShowInfoEvent(InfoMenu.SHOW_INFO, ["Attack : ", "Range : ", "FireRate : ", "$Upgrade$ : "], [attackDmg, range, fireRate,upgradeCost], true);
			dispatchEvent(event);
		}
		override public function exitInteraction():void 
		{
			super.exitInteraction();
			rangeView.setAlpha(0);
			dispatchEvent(new Event(InfoMenu.CLOSE_INFO, true));
		}
		protected function startFire() :void {
			towerArt.visible = false;
			towerFireArt.visible = true;
			
			var fireSpeed : int;
			
			if (fireRate < 30) {
				fireSpeed = 30;
			}else {
				fireSpeed = 30 + fireRate * 10;
			}
			playAnim(towerFireArt, fireSpeed);
			
		}
		override protected function animationFrameUp():void 
		{
			super.animationFrameUp();
			if (currentMovieClip.currentFrame == shootFrame) {
				shoot();
			}
		}
		protected function shoot() :void {
			
		}
		override protected function AnimationFinishedPlaying():void 
		{
			super.AnimationFinishedPlaying();
			
			startCoolDown();
			towerArt.visible = true;
			towerFireArt.alpha = 0;
			towerFireArt.gotoAndStop(1);
			
		}
		
		private function startCoolDown():void 
		{
			var coolDownTime : int;
			var fireRateCal : int;
			if (fireRate < 30) {
				fireRateCal = 30 - fireRate;
			}else {
				fireRateCal = 1;
			}
			
			coolDownTime = (fireRateCal * 50);
			
			var coolDownTimer : Timer = new Timer(coolDownTime, 1);
			
			coolDownTimer.addEventListener(TimerEvent.TIMER, afterCoolDown);
			coolDownTimer.start();
		}
		
		private function afterCoolDown(t:TimerEvent):void 
		{
			var timer : Timer = t.target as Timer;
			timer.removeEventListener(TimerEvent.TIMER, afterCoolDown);
			towerFireArt.alpha = 1;
			towerFireArt.visible = false; // zorgt er voor dat als hij gaat checken of hij kan vuren dat et pas kan na de cooldown.
			if (currentTarget != null) {
				startFire();
			}
		}
		
		public function get costTower():int 
		{
			return _costTower;
		}
		
		public function get upgradeCost():int 
		{
			return _upgradeCost;
		}
		override public function destroy():void 
		{
			currentTarget = null;
			super.destroy();
		}
		
		public function lostBuilder():void 
		{
			if (contains(towerBuildAnim)) {
				addChild(needBuilderSign);
				needBuilderSign.addEventListener(MouseEvent.CLICK, askForBuilder);
				needBuilderSign.x = -needBuilderSign.width / 2;
				needBuilderSign.y = -60;
			}
		}
		
		private function askForBuilder(e:MouseEvent):void 
		{
			var playerBase : PlayerBase = TileSystem.getPlayerBase();
			var builder : BuildUnit = new BuildUnit();
			if (playerBase.gold >= builder.costUnit) {
				playerBase.addGoldToPlayer(-builder.costUnit);
				playerBase.buildConstructUnit(this);
				removeChild(needBuilderSign);
				needBuilderSign.removeEventListener(MouseEvent.CLICK, askForBuilder);
			}
		}
	}
}