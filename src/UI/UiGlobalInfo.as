package UI 
{
	import events.HudEvent;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class UiGlobalInfo extends Sprite 
	{
		public static const GLOBAL_UI_INFO : String = "globalUiInfo";
		
		public static const GOLD_INFO : String = "goldInfoForHud";
		public static const LIVES_INFO : String = "livesInfoForHud";
		public static const WAVE_INFO : String = "waveInfoForHud";
		public static const LEVEL_INFO : String = "levelInfoForHud";
		
		//---------------
		private var _uiGlobalBg : Sprite = new GlobalInfoBg();
		
		private var _textGold : HudTextField = new HudTextField("GOLD");
		private var	_textLives : HudTextField = new HudTextField("LIVES");
		private var	_textWave : HudTextField = new HudTextField("Enemy Incomming..");
		private var	_textLevel : HudTextField = new HudTextField("LEVEL");
		
		private var _game : DisplayObjectContainer;
		
		public function UiGlobalInfo(game : DisplayObjectContainer) 
		{
			_game = game; 
			
			_uiGlobalBg.alpha = 0.8;
			addChild(_uiGlobalBg);
			
			placeHudItems();
			game.addEventListener(GLOBAL_UI_INFO, checkSentData);
		}
		
		private function checkSentData(e:HudEvent):void 
		{
			var sort : String = e.hudConstInfo;
			var data : String = e.infoData;
			
			//als ik dictionary had gebruikt had ik elk textfield zijn eigen sort mee kunnen geven en voor dit all 1 functie te hoeven gebruiken dat door de textfields heen kijkt en degene die gelinkt is met de sort de data krijgt..
			switch(sort) {
				case GOLD_INFO:
					updateGoldText(data)
				break;
				case LIVES_INFO:
					updateLivesText(data);
				break;
				case WAVE_INFO:
					updateWaveText(data);
				break;
				case LEVEL_INFO:
					updateLevelText(data);
				break;
			}
		}
		private function updateGoldText(data:String):void 
		{
			_textGold.changeText(data);
		}
		private function updateLivesText(data:String):void 
		{
			_textLives.changeText(data);
			if (int(data) < 5) {
				_textLives.changeColor(0xff0000);
			}
		}
		private function updateWaveText(data:String):void 
		{
			_textWave.changeText("Wave : " + data);
		}
		private function updateLevelText(data:String):void 
		{
			_textLevel.changeText("Level : " + data);
		}
		private function placeHudItems():void 
		{
			_textGold.x = 245;
			_textLives.x += 50;
			_textWave.x = _game.stage.stageWidth / 2 - _textWave.width / 3;
			_textLevel.x = _game.stage.stageWidth - (_textLevel.width + 100);
			_textGold.y = _textLives.y = _textWave.y = _textLevel.y += 5;
			addChild(_textGold);
			addChild(_textLives);
			addChild(_textWave);
			addChild(_textLevel);
		}
		public function destroy() :void {
			stage.removeEventListener(GLOBAL_UI_INFO, checkSentData);
		}
	}

}