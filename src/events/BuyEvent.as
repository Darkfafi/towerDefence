package events 
{
	import flash.events.Event;
	import gameControlEngine.GameObject;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class BuyEvent extends Event 
	{
		
		public var item : GameObject;
		
		public function BuyEvent(type:String,itemBought : GameObject ,bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			item = itemBought; //if item is tower . dan krijg alle tower stats als unit get all unit stats etc.
			super(type, bubbles, cancelable);
		}
		
	}

}