package towers.antiGroundTowers 
{
	import towers.Tower;
	import towers.towerProjectiles.Projectile;
	import towers.towerProjectiles.ShockBeam;
	import units.enemies.groundUnits.EnemyUnit;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class TeslaTower extends Tower 
	{
		
		public function TeslaTower() 
		{
			super();
			towerBuildAnim = new TeslaTowerBuildUpArt();
			allTowerArt = [new TeslaTowerIdle1,new TeslaTowerIdle2, new TeslaTowerIdle3];
			allFireAnim = [new TeslaTowerShoot1, new TeslaTowerShoot2, new TeslaTowerShoot3];
			allProjectiles = [ElectricBeam1,ElectricBeam3,ElectricBeam2];
			
			rangeView.setSeeAbleObjects([EnemyUnit]);
		}
		override protected function setStats():void 
		{
			_costTower = 60;
			_upgradeCost = 70;
			
			shootFrame = 50;
			fireRate = 30;
			attackDmg = 20;
			bulletSpeed = 8;
			range = 110;
		}
		override public function upgrade():void 
		{
			super.upgrade();
			
			fireRate += 10;
			attackDmg += 15;
			changeRange(range + 10);
		}
		override protected function shoot():void 
		{
			super.shoot();
			if(currentTarget != null){
				var projectile : Projectile = new ShockBeam(attackDmg, bulletSpeed, currentTarget);
				projectile.x = x;
				projectile.y = y - (allTowerArt[currentArtInt].height) + 10;
				projectile.setArt(allProjectiles[currentArtInt]);
				parent.addChild(projectile);
			}
		}
	}

}