package events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class HudEvent extends Event 
	{
		private var _hudConstInfo : String;
		private var _infoData : int;
		
		public function HudEvent(type:String,hudConstInfo : String,infoData : int, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			_hudConstInfo = hudConstInfo;
			_infoData = infoData;
			
			super(type, bubbles, cancelable);
			
		}
		
		public function get hudConstInfo():String 
		{
			return _hudConstInfo;
		}
		
		public function get infoData():int 
		{
			return _infoData;
		}
		
	}

}