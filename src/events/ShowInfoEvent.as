package events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class ShowInfoEvent extends Event 
	{
		private var _textArray : Array;
		private var _statsArray : Array;
		
		public function ShowInfoEvent(type:String,textArray : Array,statsArray : Array, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			_textArray = textArray;
			_statsArray = statsArray;
			super(type, bubbles, cancelable);
		}
		
		public function get statsArray():Array 
		{
			return _statsArray;
		}
		
		public function get textArray():Array 
		{
			return _textArray;
		}
	}
}