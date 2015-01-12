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
			allTowerArt = [new TeslaTowerIdle];
			allFireAnim = [new TeslaTowerShootArt];
			
			rangeView.setSeeAbleObjects([EnemyUnit]);
		}
		override protected function setStats():void 
		{
			_costTower = 80;
			shootFrame = 50;
			fireRate = 30;
			attackDmg = 50;
			bulletSpeed = 8;
			range = 150;
		}
		override protected function shoot():void 
		{
			super.shoot();
			if(currentTarget != null){
				var projectile : Projectile = new ShockBeam(attackDmg, bulletSpeed, currentTarget);
				projectile.x = x;
				projectile.y = y - (allTowerArt[currentArtInt].height) + 10;
				parent.addChild(projectile);
			}
		}
	}

}