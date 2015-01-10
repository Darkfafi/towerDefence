package levels 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import pathfinderAStar.grid.Grid;
	import playerControl.PlayerBase;
	import utils.Vector2D;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class TileSystem
	{
		private var _world : DisplayObjectContainer;
		public static var grid : Grid;
		public static var currentTileMap : Array;
		private static var allTiles : Array;
		public static const globalTile : Tile = new Tile();
		
		private static var playerBase : PlayerBase;
		
		public function TileSystem(world : DisplayObjectContainer) 
		{
			_world = world;
		}
		
		public function placeTiles(tileMap : Array):void 
		{
			// 0 = grond/usedTile, 1 = buildAbleTile, 2 = roadTile, 3 = main base, 4 = enemySpawnPoints (dus verader een tile naar 1 als je een toren verkoopt en naar 0 als je er 1 plaatst etc etc).
			currentTileMap = tileMap;
			
			grid = new Grid(tileMap.length, tileMap[0].length);
			allTiles = [];
			var lYRows : int = tileMap.length;
			for (var i : int = 0; i < lYRows; i++) {
				
				var lXRows : int = tileMap[i].length;
				
				for (var j : int = 0; j < lXRows; j++) {
					
					var object : Sprite;
					
					object = new Tile();
					object.x = j * object.width;
					object.y = i * object.height;
					allTiles.push(object);
					_world.addChildAt(object, 0);
					
					if (tileMap[i][j] == 3) {
						playerBase = new PlayerBase(_world);
						playerBase.x = j * globalTile.width;
						playerBase.y = i * globalTile.height;
						_world.addChild(playerBase);
					}
					
					if (tileMap[j][i] < 2 || tileMap[j][i] > 4) {
						grid.getCell(i, j).isWall = true;
					}
				}
			}
		}
		public function removeAllTiles() :void {
			for (var i : int = allTiles.length - 1; i >= 0; i--) {
				_world.removeChild(allTiles[i]);
				allTiles.splice(i, 1);
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
		
		public static function getPlayerBase() : PlayerBase {
			//trace(playerBase);
			return playerBase;
		}
		
		public static function getTileFromPos(posTarget : Vector2D) :Tile {
			var result : Tile;
			
			var tile : Tile = new Tile();
			var lYRows : int = currentTileMap.length;
			for (var i : int = 0; i < lYRows; i++) {
				var lXRows : int = currentTileMap[i].length;
				for (var j : int = 0; j < lXRows; j++) {
					if (posTarget.x <= (j * tile.width) + tile.width && posTarget.x >= j * tile.width
					&& posTarget.y <= (i * tile.height) + tile.height && posTarget.y >= i * tile.height
					){
						result = allTiles[j + (i * lYRows)];
					}
				}
			}
			return result;
		}
	}
}