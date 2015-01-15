package events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class levelSwitchEvent extends Event 
	{
		private var _level : int;
		public function levelSwitchEvent(type:String,level : int,bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			_level = level;
		}
		
		public function get level():int 
		{
			return _level;
		}
		
	}

}