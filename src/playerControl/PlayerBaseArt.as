package playerControl 
{
	import flash.display.Sprite;
	import gameControlEngine.GameObject;
	import gameControlEngine.Tags;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class PlayerBaseArt extends GameObject 
	{
		private var _frontArtBase : Sprite = new CommandCenterFrontArt();
		
		public function PlayerBaseArt() 
		{
			super();
			addTag(Tags.POSITION_ON_Y_TAG);
			addChild(_frontArtBase);
		}
		
	}

}