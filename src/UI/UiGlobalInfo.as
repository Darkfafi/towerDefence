package UI 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class UiGlobalInfo extends Sprite 
	{
		private var _uiGlobalBg : Sprite = new Sprite();
		
		private var _textGold : HudTextField = new HudTextField("GOLD");
		private var	_textLives : HudTextField = new HudTextField("LIVES");
		private var	_textWave : HudTextField = new HudTextField("WAVE");
		private var	_textLevel : HudTextField = new HudTextField("LEVEL");
		
		private var _gold : int;
		private var	_lives : int;
		private var	_wave : int;
		private var	_level : int;
		
		public function UiGlobalInfo() 
		{
			placeHudItems();
		}
		
		private function placeHudItems():void 
		{
			_textLives.x += _textGold.width;
			_textWave.x = _textLives.x + _textWave.width;
			_textLevel.x = _textWave.x + _textLevel.width;
			
			
			addChild(_textGold);
			addChild(_textLives);
			addChild(_textWave);
			addChild(_textLevel);
		}
		
	}

}