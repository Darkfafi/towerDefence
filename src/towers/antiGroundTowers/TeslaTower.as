package towers.antiGroundTowers 
{
	import media.SoundManager;
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
			_costTower = 55;
			_upgradeCost = 75;
			
			shootFrame = 50;
			fireRate = 35;
			attackDmg = 15;
			bulletSpeed = 8;
			range = 110;
		}
		override public function upgrade():void 
		{
			super.upgrade();
			
			fireRate += 5;
			attackDmg += 5 + (5 *currentArtInt);
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
				SoundManager.playSound(SoundManager.ELECTRIC_ZAP_SOUND);
			}
		}
	}

}