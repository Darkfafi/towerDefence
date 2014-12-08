package  pathfinderAStar.grid
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author Berend Weij
	 */
	public class Cell 
	{
		
		private var _g			:	Number	= 0; // de g score is de score voor het pad van het beginpunt tot deze cell. Deze score hebben we berekent
		private var _h			:	Number 	= 0; // de h score is de score voor het pad die we schatten vanaf deze cell tot het eindpunt.
		private var _f			:	Number	= 0; // f = g + h; de variabele f is de geschatte score van het beginpunt VIA deze cell naar het eindpunt
		private var _isWall		:	Boolean	= false; // boolean om deze cell als wall te definieren
		private var _isOpen		:	Boolean	=	false; // variabele om (snel) bij te houden of we deze cell als buurman hebben gezien en nog moeten checken
		private var _isClosed	:	Boolean	=	false; // variabele om bij te houden of we deze cell al hebben gecheckt
		private var _parent		:	Cell; // variabele om bij te houden wie, in het pad, mijn parent is (via welke cell kom je bij mij)
		private var _position	:	Point; // wat is mijn positie in het grid
		private var _neighbors	:	Array; // wie zijn mijn buren (cellen)
		
		
		public function Cell(x : int, y : int) 
		{
			_position	=	new Point(x, y);
		}
		
		public function get position() : Point
		{
			return _position;
		}
		
		public function get f():Number 
		{
			return _f;
		}
		
		public function set f(value:Number):void 
		{
			_f = value;
		}
		
		public function get g():Number 
		{
			return _g;
		}
		
		public function set g(value:Number):void 
		{
			_g = value;
		}
		
		public function get h():Number 
		{
			return _h;
		}
		
		public function set h(value:Number):void 
		{
			_h = value;
		}
		
		public function get isWall():Boolean 
		{
			return _isWall;
		}
		
		public function set isWall(value:Boolean):void 
		{
			_isWall = value;
		}
		
		public function get parent():Cell 
		{
			return _parent;
		}
		
		public function set parent(value:Cell):void 
		{
			_parent = value;
		}
		
		public function get isOpen():Boolean 
		{
			return _isOpen;
		}
		
		public function set isOpen(value:Boolean):void 
		{
			_isOpen = value;
		}
		
		public function get isClosed():Boolean 
		{
			return _isClosed;
		}
		
		public function set isClosed(value:Boolean):void 
		{
			_isClosed = value;
		}
		
		public function get neighbors():Array 
		{
			return _neighbors;
		}
		
		public function set neighbors(value:Array):void 
		{
			_neighbors = value;
		}
		
		public function toString() : String
		{
			return "{x:" + position.x + ", y:" + position.y + ", f: " + f + "}";
		}
	}

}