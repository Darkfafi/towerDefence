package towers.antiGroundTowers 
{
	import towers.Tower;
	import units.Unit;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class CanonTower extends Tower
	{
		public function CanonTower() 
		{
			super();
			towerBuildAnim = new BuildTowerStagesArt();
			allTowerArt = [new CanonTowerArt];
			allFireAnim = [new CanonTowerFireArt];
			
			rangeView.setSeeAbleObjects(new Array(Unit));
		}
		override protected function setStats():void 
		{
			fireRate = 30;
			attackDmg = 20;
			range = 80;
		}
		
	}

}