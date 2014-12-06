package levels 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import utils.Vector2D;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class TileSystem
	{
		private var _world : DisplayObjectContainer;
		
		public static var currentTileMap : Array;
		
		public function TileSystem(world : DisplayObjectContainer) 
		{
			_world = world;
		}
		
		public function placeTiles(tileMap : Array):void 
		{
			// 0 = grond/usedTile, 1 = buildAbleTile, 2 = roadTile (dus verader een tile naar 1 als je een toren verkoopt en naar 0 als je er 1 plaatst etc etc).
			currentTileMap = tileMap;
			var lYRows : int = tileMap.length;
			for (var i : int = 0; i < lYRows; i++) {
				
				var lXRows : int = tileMap[i].length;
				
				for (var j : int = 0; j < lXRows; j++) {
					
					var object : Sprite;
					object = new Tile();
					object.x = j * object.width;
					object.y = i * object.height;
					_world.addChildAt(object, 0);
				}
			}
		}
		public static function getTileInt(x : int, y : int) :int {
			
			var tile : Tile = new Tile();
			var j : int = x / tile.width;
			var i : int = y / tile.height;
			
			return currentTileMap[i][j];
		}
		public static function setTileInt(x : int, y : int, newTileInt : int) : void {
			var tile : Tile = new Tile();
			var j : int = x / tile.width;
			var i : int = y / tile.height;
			
			currentTileMap[i][j] = newTileInt;
		}
		
		public static function getTileIntPosList(tileInt : int) :Array {
			var posList : Array = [];
			var pos : Point;
			var tile : Tile = new Tile();
			
			var lYRows : int = currentTileMap.length;
			for (var i : int = 0; i < lYRows; i++) {
				var lXRows : int = currentTileMap[i].length;
				for (var j : int = 0; j < lXRows; j++) {
					if(currentTileMap[i][j] == tileInt){
						pos = new Point(j * tile.width, i * tile.height);
						posList.push(pos);
					}
				}
			}
			return posList;
		}
		
		public static function hitTileInt(posTarget : Vector2D) :int {
			var result : int;
			
			var tile : Tile = new Tile();
			var lYRows : int = currentTileMap.length;
			for (var i : int = 0; i < lYRows; i++) {
				var lXRows : int = currentTileMap[i].length;
				for (var j : int = 0; j < lXRows; j++) {
					if (posTarget.x <= (j * tile.width) + tile.width && posTarget.x >= j * tile.width
					&& posTarget.y <= (i * tile.height) + tile.height && posTarget.y >= i * tile.height
					){
						result = getTileInt(j * tile.width, i * tile.height);
					}
				}
			}
			return result;
		}
	}
}