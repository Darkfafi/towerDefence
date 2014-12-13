package towers 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import gameControlEngine.GameObject;
	import gameControlEngine.Tags;
	import levels.TileSystem;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Tower extends GameObject
	{
		public static const TOWER_BUILD : String = "towerFinishedBuilding";
		
		//na het buiden van de tower addTag de update tag om het ook zijn functie te laten doen.
		
		//target
		protected var targets : Array = [];
		protected var currentTarget : GameObject = null;
		
		protected var range : Number;
		protected var rangeView : RangeView = new RangeView();
		protected var baseTileSize : Sprite = new Sprite(); // <== hiermee word de toren neergezet en worden alle hittests mee uitgevoert
		
		//tower Art
		protected var towerBuildAnim : MovieClip; //deze array bevat alle construct tower art.
		protected var allTowerArt : Array = []; // deze array bevat alle tower/upgrade art.
		
		//build tower with timer. Every timer event it changes art in building with gotoAndStop.
		public function Tower() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			
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
			setStats();
			setHitBox(-baseTileSize.width / 2, -baseTileSize.height, baseTileSize.width, baseTileSize.height);
			
		}
		
		protected function setStats():void 
		{
			
		}
		override public function update():void 
		{
			super.update();
			//trace(targets[0]);
			if(currentTarget != targets[0]){
				currentTarget = targets[0]; //als er een target is dan stopt hij die er in anders is currentTarget null
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
				var art : MovieClip = allTowerArt[0];
				addRangeView();
				addChild(art);
			}
		}
		
		private function addRangeView():void 
		{
			rangeView.addTag(Tags.COLLIDER_TAG);
			rangeView.addTag(Tags.RANGE_COLLIDER_TAG);
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
			towerBuildAnim.stop();
			addChild(towerBuildAnim);
		}
		
		override public function onInteraction():void 
		{
			super.onInteraction();
			rangeView.setAlpha(0.4);
			trace("show info and upgrade stats / cost");
		}
		override public function exitInteraction():void 
		{
			super.exitInteraction();
			rangeView.setAlpha(0);
			trace("close info and upgrade stats / cost");
		}
		
		public function addTarget(target:GameObject):void 
		{
			targets.push(target);
		}
		
		public function removeTarget(target:GameObject):void 
		{
			var index : int = targets.indexOf(target);
			targets.splice(index, 1);
		}
	}
}