package gameControlEngine 
{
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Tags 
	{
		/**
		 * This tag allowes you to use the 'update' function.
		*/
		public static const UPDATE_TAG : String = "updateTag";
		/**
		 * This tag allowes you to use the 'onInteraction' function.
		*/
		public static const INTERACTIVE_TAG : String = "interactiveTag";
		/**
		 * This tag allowes you to use all 'onCollision' functions.
		*/
		public static const COLLIDER_TAG : String = "colliderTag";
		
		
		/**
		 * This will position the object on the y. If the y is higher than another gameobject then it will be placed underneath it.
		 */
		public static const POSITION_ON_Y_TAG : String = "positionOnYTag";
		
		/**
		 * This will position the object always on top.
		 */
		public static const POSITION_ON_TOP_TAG : String = "positionOnTopTag";
		
		//----------------------------game tags----------------------------
		
		/**
		 * This tag allows you to see what a range collider is.
		*/
		public static const RANGE_COLLIDER_TAG : String = "rangeCollider";
		
	}

}