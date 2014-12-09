package towers 
{
	import flash.display.Sprite;
	import flash.events.Event;
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
		//na het buiden van de tower addTag de update tag om het ook zijn functie te laten doen.
		// target var.
		protected var range : Number;
		protected var baseTileSize : Sprite = new Sprite(); // <== hiermee word de toren neergezet en worden alle hittests mee uitgevoert
		protected var allTowerArt : Array = []; // deze array bevat alle consstruct en tower/ tower upgrade art.
		
		protected var buildStages : int;
		protected var buildTimer : Timer;
		protected var buildTime : int; // doe gedeelt door 4 voor de 4 stages van opbouw in construction voor de timer.
		
		//build tower with timer. Every timer event it changes art in building with gotoAndStop.
		public function Tower() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			addTag(Tags.INTERACTIVE_TAG);
			
			baseTileSize.graphics.beginFill(0x000000, 1);
			baseTileSize.graphics.drawRect(0, 0, TileSystem.globalTile.width, TileSystem.globalTile.height);
			baseTileSize.graphics.endFill();
			addChild(baseTileSize);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			setValues();
			drawTower();
		}
		
		private function setValues():void 
		{
			
		}
		
		private function drawTower():void 
		{
			//als een tower word geaddChild dan in de gamenEgine laat alle towers die er al zijn heraddChild worden als hun tile lager zijn dan die is geaddChild.
			removeChild(baseTileSize);
			graphics.beginFill(0x000000, 1);
			graphics.drawRect(0, 0, TileSystem.globalTile.width, TileSystem.globalTile.height);
			graphics.endFill();
		}
		
		protected function setBuildTime(buildTimeInt : int) :void 
		{
			buildStages = buildTimeInt;
			buildTime = 1000 * buildStages;
			buildTimer = new Timer(buildTime / buildStages, buildStages);
		}
		
		override public function onInteraction():void 
		{
			super.onInteraction();
			trace("show info and upgrade stats/ cost");
		}
		
	}

}