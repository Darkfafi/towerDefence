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
		
		// target var.
		protected var range : Number;
		protected var rangeView : GameObject = new GameObject();
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
			changeRange(100); // Test
		}
		
		protected function changeRange(_range : int) :void {
			range = _range;
			drawRangeView();
		}
		
		private function drawRangeView():void 
		{
			if (contains(rangeView)) {
				rangeView.graphics.clear();
			}
			rangeView.alpha = 0;
			rangeView.graphics.beginFill(0xFF00FF, 1);
			rangeView.graphics.drawCircle(0, 0, range);
			rangeView.graphics.endFill();
			rangeView.y -= baseTileSize.height / 2;
			rangeView.setHitBox(-rangeView.width / 2, - rangeView.height / 2, rangeView.width, rangeView.height);
		}
		
		protected function drawTower():void 
		{
			//als een tower word geaddChild dan in de gamenEgine laat alle towers die er al zijn heraddChild worden als hun tile lager zijn dan die is geaddChild.
			removeChild(baseTileSize);
			towerBuildAnim = new BuildTowerStagesArt();
			towerBuildAnim.stop();
			addChild(towerBuildAnim);
		}
		
		override public function onInteraction():void 
		{
			super.onInteraction();
			rangeView.alpha = 0.4;
			trace("show info and upgrade stats / cost");
		}
		override public function exitInteraction():void 
		{
			super.exitInteraction();
			rangeView.alpha = 0;
			trace("close info and upgrade stats / cost");
		}
	}
}