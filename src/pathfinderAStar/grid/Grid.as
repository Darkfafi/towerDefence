package  pathfinderAStar.grid
{
	/**
	 * ...
	 * @author Berend Weij
	 */
	public class Grid 
	{
		
		// variabelen om het grid en de grootte van het grid bij te houden
		private var _grid	:	Array;
		private var _width	:	int;
		private var _height	:	int;
		
		public function Grid(width : int, height: int) : void
		{
			this.width = width;
			this.height = height;
			_grid = [];
			
			// we doen een forLoop in een forLoop om alle cellen aan te maken
			for (var x : int = 0; x < width; x++)
			{
				_grid[x] = [];
				for (var y : int = 0; y < height; y++)
				{
					_grid[x][y] = new Cell(x, y);
				}
			}
		}
		
		// functie om een specifieke cell op te halen
		public function getCell(x : int, y : int) : Cell
		{
			if (_grid[x] && _grid[x][y])
			{
				return _grid[x][y];
			}
			return undefined;
		}
		
		// functie om alle cellen te resetten
		public function reset() : void
		{
			var currentCell	:	Cell;
			var l : int	=	_grid.length;
			for (var x : int = 0; x < l; x++)
			{
				for (var y : int = 0; y < _grid[x].length; y++)
				{
					currentCell	=	_grid[x][y];
					currentCell.f = 0;
					currentCell.g = 0;
					currentCell.h = 0;
					currentCell.isClosed	=	false;
					currentCell.isOpen		=	false;
					currentCell.parent = null;
				}	
			}
		}
		
		public function get width():int 
		{
			return _width;
		}
		
		public function set width(value:int):void 
		{
			_width = value;
		}
		
		public function get height():int 
		{
			return _height;
		}
		
		public function set height(value:int):void 
		{
			_height = value;
		}
		
	}

}