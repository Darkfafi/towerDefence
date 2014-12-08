package  pathfinderAStar.grid
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author Berend Weij
	 */
	public class AStar 
	{
		
		// de g score die we toekennen aan een stap horizontaal of verticaal
		public static var horizontalScore	:	int	=	1;
		
		// de g score die we toekennen aan een stap diagonaal
		public static var diagonalScore		:	int	=	1.414;
		
		public static function search(grid : Grid, start : Point, end : Point) : Array
		{
			// we resetten de score van de vorige check (alle g, f en h scores bij alle cellen
			grid.reset();
			
			// we declareren alle variabelen die we nodig hebben
			var openList : Array   = [];	// lijst met alle cellen die we nog moeten checken
			var closedList : Array = [];	// lijst met alle cellen die we reeds hebben gecheckt
			var currentCell : Cell;			// de huidige cell waar we de buren van aan het berekenen zijn
			var neighbor : Cell;			// een variabele om een referentie in bij te houden naar 1 van de cellen naast currentCell
			var gScore : Number;			// variabele om tijdelijk de g score van de cell bij de houden
			var gScoreIsBest : Boolean;		// variabele om bij te houden of de huidige g score van de currentCell de beste is tot nu toe
			var neighbors : Array;			// array om alle buren in bij te houden
			
			// functie om de openList (array met alle cellen die we nog moeten checken) te sorteren
			function sortOnF(a:Cell, b:Cell):Number
			{
				if (a.f > b.f || a.f == b.f && a.h > b.h) {
					// als we 1 terug geven dan komt a NA b in de lijst
					return 1;
				} else  {
					// als we -1 terug geven dan komt a VOOR b in de lijst
					return -1;
				}
			}
			
			// we starten de zoektocht bij de cell op de start coordinaten
			openList.push(grid.getCell(start.x, start.y));
			
			// vervolgens gaan we door het grid heen loopen
			// dit doen we net zolang tot we het pad hebben gevonden OF totdat we geen cellen meer kunnen vinden om te checken
			while (openList.length > 0)
			{
				// sorteer de lijst met punten die we nog moeten checken op hun f score (de f score is de score die aangeeft hoeveel het pad naar het eindpunt 'waarschijnlijk' kost)
				openList.sort(sortOnF);
				
				// we pakken de eerste waarde uit de array openList. Door het sorteren zal dit de cell zijn met de laagste f waarde (en daarmee de kortst geschatte weg naar het eindpunt)
				currentCell = openList[0];
				// als de huidige cell hetzelfde is als ons eindpunt, dan hebben we het eindpunt bereikt
				if (currentCell.position.equals( end ) ) {
					// we gaan de array met het pad vullen en terug geven
					var path : Array = [];
					
					// dit doen we door alle 'parent' cells heen te loopen en ze te pushen in de path array
					// zo gaan we vanaf het eindpunt terug naar het beginpunt
					while(currentCell.parent) {
						path.push(currentCell);
						currentCell = currentCell.parent;
					}
					// uiteindelijk willen we het pad natuurlijk wel van voor naar achteren dus we draain de array om
					return path.reverse();
				}
				
				// de cell die we nu aan het checken zijn mag van de openList af (we hoeven hem niet meer te
				// checken aangezien we hem NU al aan het checken zijn)
				openList.splice(openList.indexOf(currentCell), 1);
				// en we voegen hem toe aan de closedList zodat we bijhouden welke cellen we al hebben behad
				closedList.push(currentCell);
				currentCell.isClosed	=	true;
				currentCell.isOpen		=	false;
				
				// vervolgens gaan we de socres berekenen van alle buren
				// hierdoor weten we naar welke buurman we willen stappen (dit is de buurman met de laagste f score)
				// als we nog niet de buren van de currentCell hebben berekent dan doen we dat nu
				if (!currentCell.neighbors)
				{
					currentCell.neighbors	=	getNeighbors(grid, currentCell)
				}
				
				neighbors = currentCell.neighbors;
				
				// we gaan door alle buren heen loopen om hun score te berekenen
				var l : int = neighbors.length;
				for (var i : int = 0; i<l; i++) {
					neighbor = neighbors[i];
					
					if(neighbor.isClosed || currentCell.isWall) {
						// dit is een cell die we al hebben gehad OF dit is een cell die een muur is
						// we slaan deze cell over en gaan door met het loopen over de andere cellen
						continue;
					}
	 
					// de g score zijn de kosten om van het begin punt naar deze cell te komen
					// de g score van een buur cell is de g score van de currentCell plus de kosten van de nieuwe stap
					if (isDiagonal(currentCell, neighbor))
					{
						// het is een diagonale stap naar deze cell dus we gebruiken de diagonalScore om de g te berekenen
						gScore = currentCell.g + diagonalScore;
					}
					else
					{
						// het is een horizontale of verticale stap
						gScore = currentCell.g + horizontalScore;
					}
					
					gScoreIsBest = false;
	 
					// als we nog niet bij deze 'buur' cell zijn geweest dan voegen we hem toe aan openList zodat we hem ook kunnen gaan checken
					if(!neighbor.isOpen) {												
						gScoreIsBest = true;
						// de h score is de socre dat weergeeft hoeveel wij de kosten schatten naar het eindpunt
						neighbor.h = heuristic(neighbor.position, end);
						
						openList.push(neighbor);
						neighbor.isOpen	=	true;
					}
					else if(gScore < neighbor.g) {
						// we zijn al bij deze buur cell geweest. Maar de weg hoe we er nu komen is gunstiger
						gScoreIsBest = true;
					}
	 
					if (gScoreIsBest) {
						// We hebben een optimaal pad gevonden naar deze cell
						// we slaan alle resturende info op in de cell
						neighbor.parent = currentCell; // de cell weet zo vanaf welke cell we bij hem komen
						neighbor.g = gScore;
						neighbor.f = neighbor.g + neighbor.h;
					}
				}
			}
	 
			// No result was found -- empty array signifies failure to find path
			return [];
		}
		
		// deze functie kan 'schatten' wat de kosten zijn van een bepaald punt naar een ander punt
		// deze manier van berekenen noem je de Manhattan manier van A Star
		private static function heuristic(pos0 : Point, pos1 : Point) : int
		{
			// This is the Manhattan distance
			var d1 : int = Math.abs (pos1.x - pos0.x);
			var d2 : int = Math.abs (pos1.y - pos0.y);
			return d1 + d2;
		}
		
		// functie om te bepalen of de stap die je wil maken naar een 'buur' cell diagonaal is
		private static function isDiagonal(center:Cell, neighbor:Cell):Boolean {
			if(center.position.x != neighbor.position.x && center.position.y != neighbor.position.y) {
				return true;
			}
			return false;
		}
		
		// functie om de buren op te halen voor een bepaalde cell
		private static function getNeighbors(grid : Grid, cell : Cell) : Array
		{
			var neighbors : Array = [];
			var x : int = cell.position.x;
			var y : int = cell.position.y;
			
			// check voor horizontale en verticale cellen
			if(grid.getCell(x-1, y)) {
				neighbors.push(grid.getCell(x-1, y));
			}
			if(grid.getCell(x+1, y)) {
				neighbors.push(grid.getCell(x+1, y));
			}
			if(grid.getCell(x, y-1)) {
				neighbors.push(grid.getCell(x, y-1));
			}
			if(grid.getCell(x, y+1)) {
				neighbors.push(grid.getCell(x, y+1));
			}
			
			// check voor diagonale cellen
			if(grid.getCell(x-1, y-1)) {
				neighbors.push(grid.getCell(x-1, y-1));
			}
			if(grid.getCell(x+1, y-1)) {
				neighbors.push(grid.getCell(x+1, y-1));
			}
			if(grid.getCell(x+1, y+1)) {
				neighbors.push(grid.getCell(x+1, y+1));
			}
			if(grid.getCell(x-1, y+1)) {
				neighbors.push(grid.getCell(x-1, y+1));
			}
			return neighbors;
		}
		
	}
}