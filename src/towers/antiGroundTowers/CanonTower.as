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
			towerBuildAnim = new CanonTowerBuildUpArt();
			allTowerArt = [new CannonTowerIdle, new TowerLaserIdle];
			allFireAnim = [new CannonTowerShootArt, new TowerLaserShoot];
			
			rangeView.setSeeAbleObjects([EnemyUnit]);
		}
		override protected function setStats():void 
		{
			_costTower = 80;
			fireRate = 40;
			attackDmg = 50;
			bulletSpeed = 8;
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