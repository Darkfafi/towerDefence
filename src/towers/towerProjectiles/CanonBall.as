package towers.towerProjectiles 
{
	import units.Unit;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class CanonBall extends DroppingProjectile 
	{
		
		public function CanonBall(bulletDamage:int, bulletSpeed:int, bulletTarget:Unit, shootPower:Number=50) 
		{
			super(bulletDamage, bulletSpeed, bulletTarget, shootPower);
			
		}
		
	}

}