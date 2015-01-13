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
		private var _infoData : String;
		
		public function HudEvent(type:String,hudConstInfo : String,infoData : String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			_hudConstInfo = hudConstInfo;
			_infoData = infoData;
			
			super(type, bubbles, cancelable);
			
		}
		
		public function get hudConstInfo():String 
		{
			return _hudConstInfo;
		}
		
		public function get infoData():String 
		{
			return _infoData;
		}
		
	}

}