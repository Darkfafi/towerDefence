package towers.towerProjectiles 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import gameControlEngine.GameObject;
	import gameControlEngine.Tags;
	import units.Unit;
	import utils.Vector2D;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Projectile extends GameObject
	{
		protected var _currentartInt : int;
		
		protected var art : MovieClip = new MovieClip();
		
		protected var damage : int; 
		protected var speed : int; 
		protected var target : Unit;
		protected var targetPosition : Vector2D;
		
		
		//movement
		protected var _position : Vector2D = new Vector2D();
		protected var _velocity : Vector2D = new Vector2D();
		
		public function Projectile(bulletDamage : int,bulletSpeed : int,bulletTarget : Unit) 
		{
			
			addEventListener(Event.ADDED_TO_STAGE, init);
			damage = bulletDamage;
			speed = bulletSpeed;
			target = bulletTarget;
		}
		
		public function setArt(artProjectile : Class):void 
		{
			art =  new artProjectile as MovieClip;
			addChild(art);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			_position = new Vector2D(x, y);
			addTag(Tags.UPDATE_TAG);
			addTag(Tags.POSITION_ON_TOP_TAG);
		}
		
		public function set currentartInt(value:int):void 
		{
			_currentartInt = value;
		}
	}
}