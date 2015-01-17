package media
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class LoadingScreen extends Sprite
	{		
		public function LoadingScreen() 
		{
			graphics.beginFill(0x343434, 1);
			graphics.drawRect(0, 0, 800, 600);
			graphics.endFill();
			
			var loadingText : TextField = new TextField();
			loadingText.defaultTextFormat = new TextFormat('Comic Sans', 30, 0x6666FF);
			loadingText.width = 800;
			loadingText.text = "LOADING! PLEASE WAIT..";
			loadingText.x = 220;
			loadingText.y = 260;
			addChild(loadingText);
		}
		
	}

}