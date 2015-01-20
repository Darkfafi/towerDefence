package towers.antiGroundTowers 
{
	import media.SoundManager;
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
			
			_expRadius = 35;
			
			fireRate = 10;
			attackDmg = 5;
			bulletSpeed = 6;
			range = 100;
		}
		override protected function doUpgrade():void 
		{
			super.doUpgrade();
			
			fireRate += 3;
			attackDmg += 5 * currentArtInt;
			changeRange(range + 10);
			_expRadius += 5;
		}
		override protected function shoot():void 
		{
			if(currentTarget != null){
				super.shoot();
				SoundManager.playSound(SoundManager.CANON_TOWER_SOUND);
				var projectile : Projectile = new DroppingProjectile(attackDmg, bulletSpeed, currentTarget, 50,_expRadius);
				projectile.setArt(allProjectiles[currentArtInt]);
				projectile.x = x;
				projectile.y = y - height / 2;
				parent.addChild(projectile);
			}
		}
	}

}