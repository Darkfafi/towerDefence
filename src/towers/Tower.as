package towers 
{
	import flash.display.Sprite;
	import gameControlEngine.GameObject;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Tower extends GameObject
	{
		// target var.
		protected var range : Number;
		protected var baseTileSize : Sprite; // <== hiermee word de toren neergezet.
		
		protected var buildTime : int = 4000; // doe gedeelt door 4 voor de 4 stages van opbouw in construction voor de timer.
		
		//build tower with timer. Every timer event it changes art in building with gotoAndStop.
		public function Tower() 
		{
			
		}
		
	}

}