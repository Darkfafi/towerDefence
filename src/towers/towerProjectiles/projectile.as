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
		protected var art : Sprite = new Sprite();
		
		protected var damage : int; 
		protected var speed : int; 
		protected var target : GameObject;
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
			
			art.graphics.beginFill(0x000000, 1);
			art.graphics.drawCircle(0, 0, 5);
			art.graphics.endFill();
			addChild(art);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			_position = new Vector2D(x, y);
			addTag(Tags.UPDATE_TAG);
			addTag(Tags.POSITION_ON_TOP_TAG);
		}
		override public function update():void 
		{
			super.update();
		}
	}

}