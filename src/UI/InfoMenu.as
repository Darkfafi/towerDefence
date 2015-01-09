package UI 
{
	import events.ShowInfoEvent;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import levels.TileSystem;
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
		
		private var currentAnimInt : int;
		
		private var allText : Array = [];
		
		public function InfoMenu() 
		{
			drawBg();
			placeButtons();
		}
		
		private function placeButtons():void 
		{
			//als je probeerd te upgraden terwijl je er op heb gedrukt zonder te bouwen of het op max zit dan laat dat zien op scherm met "Max upgraded" if "Error : Can't upgrade N.a.P.T."
			
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
			if(allText.length > 0){
				closeInfoText(false);
			}
			for (var i : int = 0; i < e.textArray.length; i++) {
				textfield = new TextField();
				textfield.x -= 180;
				textfield.y = -80 + (i * 12); 
				textfield.text = e.textArray[i];
				addChild(textfield);
				textfield.visible = false;
				allText.push(textfield);
			}
			for (i = 0; i < e.statsArray.length; i++ ) {
				textfield = new TextField();
				textfield.x -= 130;
				textfield.y = -80 + (i * 12); 
				textfield.text = e.statsArray[i];
				addChild(textfield);
				textfield.visible = false;
				allText.push(textfield);
			}
			switchAnimation(INFO_EMPTY_TO_FULL);
		}
		
		public function closeInfoText(showAnim : Boolean = true) :void {
			for (var i : int = allText.length - 1; i >= 0; i--) {
				removeChild(allText[i]);
			}
			allText = [];
			if (showAnim) {
				//laat overgang van full naar emtpy zien en in update in empty laten.
				switchAnimation(INFO_FULL_TO_EMPTY);
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
	}
}