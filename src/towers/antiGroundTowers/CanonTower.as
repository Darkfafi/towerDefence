package towers.antiGroundTowers 
{
	import towers.Tower;
	import towers.towerProjectiles.DroppingProjectile;
	import towers.towerProjectiles.Projectile;
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
			fireRate = 40;
			attackDmg = 20;
			bulletSpeed = 5;
			range = 80;
		}
		override protected function shoot():void 
		{
			super.shoot();
			var projectile : Projectile = new DroppingProjectile(attackDmg, bulletSpeed, currentTarget);
			projectile.x = x;
			projectile.y = y - height / 2;
			parent.addChild(projectile);
		}
		
	}

}