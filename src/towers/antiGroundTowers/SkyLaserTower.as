package towers.antiGroundTowers 
{
	import flash.events.Event;
	import media.SoundManager;
	import towers.Tower;
	import towers.towerProjectiles.Projectile;
	import towers.towerProjectiles.SkyLaserBeam;
	import units.enemies.groundUnits.EnemyUnit;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class SkyLaserTower extends Tower 
	{
		private var _expRadius : int;
		public function SkyLaserTower() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, init);
			towerBuildAnim = new SkyLaserTowerBuildUpArt();
			allTowerArt = [new SkyLaserIdle1Anim, new SkyLaserIdle2Anim, new SkyLaserIdle3Anim];
			allFireAnim = [new SkyLaserShoot1Anim, new SkyLaserShoot2Anim, new SkyLaserShoot3Anim];
			allProjectiles = [SkyLaser1Art,SkyLaser2Art,SkyLaser3Art];
			
			rangeView.setSeeAbleObjects([EnemyUnit]);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			shootFrame = allFireAnim[currentArtInt].totalFrames;
		}
		override protected function setStats():void 
		{
			_costTower = 90;
			_upgradeCost = 100;
			
			_expRadius = 40;
			
			fireRate = 10;
			attackDmg = 20;
			bulletSpeed = 8;
			range = 125;
		}
		override public function upgrade():void 
		{
			super.upgrade();
			
			fireRate += 3.25;
			
			shootFrame = allFireAnim[currentArtInt].totalFrames;
			
			attackDmg += 5;
			changeRange(range + 10);
			_expRadius += 10;
			
		}
		override protected function animationFrameUp():void 
		{
			super.animationFrameUp();
			if (allFireAnim[currentArtInt].visible == true && allFireAnim[currentArtInt].currentFrame == 2) {
				SoundManager.playSound(SoundManager.SKY_LASER_SOUND);
			}
		}
		override protected function shoot():void 
		{
			super.shoot();
			if (currentTarget != null) {
				var projectile : Projectile = new SkyLaserBeam(attackDmg, bulletSpeed, currentTarget,_expRadius);
				projectile.setArt(allProjectiles[currentArtInt]);
				projectile.x = currentTarget.x;
				projectile.y = currentTarget.y;
				parent.addChild(projectile);
			}
		}	
	}
}