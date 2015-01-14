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
		private var _expRadius : int = 40;
		
		public function CanonTower() 
		{
			super();
			towerBuildAnim = new CanonTowerBuildUpArt();
			allTowerArt = [new CanonTowerIdle1, new CanonTowerIdle2, new CanonTowerIdle3];
			allFireAnim = [new CanonTowerShoot1, new CanonTowerShoot2, new CanonTowerShoot3];
			allProjectiles = [CanonArt1,CanonArt1,CanonArt1];
			
			
			rangeView.setSeeAbleObjects([EnemyUnit]);
		}
		override protected function setStats():void 
		{
			_costTower = 50;
			_upgradeCost = 60;
			
			fireRate = 10;
			attackDmg = 20;
			bulletSpeed = 8;
			range = 100;
		}
		override public function upgrade():void 
		{
			super.upgrade();
			
			fireRate += 10;
			attackDmg += 5 * currentArtInt;
			changeRange(range + 20);
			_expRadius += 10;
		}
		override protected function shoot():void 
		{
			if(currentTarget != null){
				super.shoot();
				var projectile : Projectile = new DroppingProjectile(attackDmg, bulletSpeed, currentTarget, 50,_expRadius);
				projectile.setArt(allProjectiles[currentArtInt]);
				projectile.x = x;
				projectile.y = y - height / 2;
				parent.addChild(projectile);
			}
		}
	}

}