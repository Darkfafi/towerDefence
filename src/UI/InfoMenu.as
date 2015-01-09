package UI 
{
	import events.ShowInfoEvent;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import gameControlEngine.GameObject;
	import levels.TileSystem;
	import towers.Tower;
	import units.enemies.groundUnits.EnemyUnit;
	import units.Unit;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class InfoMenu extends Sprite
	{
		public static const SHOW_INFO : String = "showInfo";
		public static const CLOSE_INFO : String = "closeInfo";
		
		private static const INFO_EMPTY : int = 0; 
		private static const INFO_EMPTY_TO_FULL : int = 1; 
		private static const INFO_FULL : int = 2; 
		private static const INFO_FULL_TO_EMPTY : int = 3; 
		
		private var bgArt : Sprite = new InfoBg();
		
		private var screenArtList : Array = [new InfoScreenEmptyArt, new InfoScreenEmptyToFullArt, new InfoScreenArt, new InfoScreenFullToEmptyArt];
		
		private var upgradeButton : SimpleButton = new UpgradeButtonArt(),
					sellButton    : SimpleButton = new SellButtonArt();
		
		private var _currentDisplayTarget : GameObject;
		
		private var currentAnimInt : int;
		
		private var allText : Array = [];
		
		public function InfoMenu() 
		{
			drawBg();
			placeButtons();
			addEventListener(MouseEvent.CLICK, clickedInMenu);
		}
		
		private function clickedInMenu(e:MouseEvent):void 
		{
			
			if (_currentDisplayTarget is Tower) {
				var tower : Tower = _currentDisplayTarget as Tower;
				if (e.target == upgradeButton) {
					trace("UPGRADE " + tower);
					tower.upgrade();
				}else if (e.target == sellButton){
					tower.sell();
				}	
			}else if (_currentDisplayTarget is Unit && _currentDisplayTarget is EnemyUnit == false) {
				var unit : Unit = _currentDisplayTarget as Unit;
				if (e.target == upgradeButton) {
					trace("UPGRADE " + unit);
				}else if (e.target == sellButton){
					unit.sell();
				}	
			}
		}
		
		private function placeButtons():void 
		{
			//als je probeerd te upgraden terwijl je er op heb gedrukt zonder te bouwen of het op max zit dan laat dat zien op scherm met "Max upgraded" if "Error : Can't upgrade N.a.P.T."	
			upgradeButton.x = sellButton.x -= 30;
			
			upgradeButton.y -= 60;
			sellButton.y -= 10;
			
			addChild(upgradeButton);
			addChild(sellButton);
		}
		
		private function drawBg():void 
		{
			bgArt.x -= bgArt.width / 2;
			addChild(bgArt);
			
			for (var i : int = 0; i < screenArtList.length; i++) {
				var screen : MovieClip = screenArtList[i] as MovieClip;
				screen.x -= screen.width / 2 + 73;
				screen.y -= 7;
				addChild(screen);
				screenArtList[i] = screen;
				screen.total
			}
			switchAnimation(INFO_EMPTY);
		}
		
		private function switchAnimation(animInt : int) :void {
			for (var i : int = 0; i < screenArtList.length; i++) {
				screenArtList[i].gotoAndStop(1);
				screenArtList[i].visible = false;
			}
			currentAnimInt = animInt;
			screenArtList[animInt].visible = true;
			screenArtList[animInt].play();
			
			if (animInt == INFO_EMPTY_TO_FULL || animInt == INFO_FULL_TO_EMPTY) {
				addEventListener(Event.ENTER_FRAME, checkAnim);
			}
		}
		
		public function setInfoText(e : ShowInfoEvent) :void {
			var textfield : TextField;
			if (allText.length > 0) {
				closeInfoText(null,false);
			}
			
			_currentDisplayTarget = e.target as GameObject;
			
			for (var i : int = 0; i < e.textArray.length; i++) {
				textfield = new TextField();
				textfield.selectable = false;
				textfield.x -= 180;
				textfield.y = -80 + (i * 12); 
				textfield.text = e.textArray[i];
				textfield.width =  e.textArray[i].length * 5;
				addChild(textfield);
				textfield.visible = false;
				allText.push(textfield);
			}
			for (i = 0; i < e.statsArray.length; i++ ) {
				textfield = new TextField();
				textfield.selectable = false;
				textfield.x -= 130;
				textfield.y = -80 + (i * 12); 
				textfield.text = e.statsArray[i];
				textfield.width =  e.textArray[i].length * 5;
				addChild(textfield);
				textfield.visible = false;
				allText.push(textfield);
			}
			switchAnimation(INFO_EMPTY_TO_FULL);
		}
		
		public function closeInfoText(e : Event, showAnim : Boolean = true) :void {
			if(e == null || e.target == _currentDisplayTarget){
				for (var i : int = allText.length - 1; i >= 0; i--) {
					removeChild(allText[i]);
				}
				allText = [];
				if (showAnim) {
					//laat overgang van full naar emtpy zien en in update in empty laten.
					switchAnimation(INFO_FULL_TO_EMPTY);
				}
			}
		}
		
		private function checkAnim(e:Event):void 
		{
			if (screenArtList[currentAnimInt].currentFrame == screenArtList[currentAnimInt].totalFrames) {
				if (currentAnimInt == INFO_EMPTY_TO_FULL) {
					switchAnimation(INFO_FULL);
					showText();
				}else if (currentAnimInt == INFO_FULL_TO_EMPTY) {
					switchAnimation(INFO_EMPTY);
				}
				removeEventListener(Event.ENTER_FRAME, checkAnim);
			}
			//ook als hij net uit grijs gaat dat text komt.
		}
		
		private function showText():void 
		{
			for (var i : int = 0; i < allText.length; i++) {
				allText[i].visible = true;
			}
		}
		
		public function get currentDisplayTarget():GameObject 
		{
			return _currentDisplayTarget;
		}
	}
}