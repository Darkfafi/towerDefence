package towers.antiGroundTowers 
{
	import towers.Tower;
	import towers.towerProjectiles.DroppingProjectile;
	import towers.towerProjectiles.Projectile;
	import units.enemies.groundUnits.EnemyUnit;
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
			
			rangeView.setSeeAbleObjects([EnemyUnit]);
		}
		override protected function setStats():void 
		{
			_costTower = 80;
			fireRate = 40;
			attackDmg = 25;
			bulletSpeed = 6;
			range = 100;
		}
		override protected function shoot():void 
		{
			super.shoot();
			var projectile : Projectile = new DroppingProjectile(attackDmg, bulletSpeed, currentTarget,50);
			projectile.x = x;
			projectile.y = y - height / 2;
			parent.addChild(projectile);
		}
	}

}