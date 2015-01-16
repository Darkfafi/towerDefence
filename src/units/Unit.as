package units 
{
	import events.ShowInfoEvent;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import gameControlEngine.gameExtraClasses.RangeView;
	import gameControlEngine.gameExtraClasses.WatchingObject;
	import gameControlEngine.GameObject;
	import gameControlEngine.Tags;
	import levels.LevelPlacer;
	import levels.TileSystem;
	import pathfinderAStar.grid.AStar;
	import playerControl.PlayerBase;
	import UI.HpBar;
	import UI.InfoMenu;
	import units.alies.BuildUnit;
	import units.enemies.groundUnits.EnemyUnit;
	import utils.Vector2D;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Unit extends WatchingObject
	{
		private var hpBar : HpBar;
		
		protected var deployUnit : Boolean = true;
		
		protected const WALK_ANIM : int = 0;
		protected const ATTACK_ANIM : int = 1;
		protected const DEATH_ANIM : int = 2;
		protected const IDLE_ANIM : int = 3; //bij builder die geen idle heeft is dit build anim.
		
		protected var movAtDthAnimList : Array = [];
		protected var animations : Array = [];
		
		protected var destination : Point = new Point();
		protected var _waypointList : Array = [];
		
		//or enemy or destination
		protected var target : Vector2D = new Vector2D(); //for where to move (target vector to move to)
		public var targetUnit : Unit = null; //for target unit. Unit to fcus on when seen.
		public var costUnit : int;
		
		//stats
		protected var _health : int;
		protected var attackDmg : int;
		protected var viewDistance : Number;
		protected var _speed : int;
		
		//movement
		protected var _moving : Boolean = true;
		protected var _position : Vector2D = new Vector2D();
		protected var _velocity : Vector2D = new Vector2D();
		
		public function Unit() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			setStats();
			addTag(Tags.UPDATE_TAG);
			addTag(Tags.INTERACTIVE_TAG);
			addTag(Tags.COLLIDER_TAG);
			addTag(Tags.POSITION_ON_Y_TAG);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			_position.x = this.x;
			_position.y = this.y;
			setHitBox( -20, -20, 25, 20);
			addRangeView();
		}	
		private function addRangeView():void 
		{
			addChild(rangeView);
			changeViewDistance(viewDistance);
		}
		
		protected function changeViewDistance(_viewDistance : int) :void {
			viewDistance = _viewDistance;
			rangeView.drawRangeView(viewDistance);
		}
		protected function setStats():void 
		{
			
			hpBar = new HpBar(_health);
			hpBar.y += 3;
			addChild(hpBar);
		}
		override protected function drawHitBoxObjectArt():void 
		{
			super.drawHitBoxObjectArt();
			drawUnit();
		}
		protected function drawUnit():void 
		{
			for (var i : int = 0; i < movAtDthAnimList.length; i++) {
				var anim : MovieClip = movAtDthAnimList[i] as MovieClip;
				addChild(anim);
				animations.push(anim);
			}
			switchAnim(WALK_ANIM);
		}
		protected function switchAnim(animInt : int,playType : int = 0) :void {
			for (var i : int = 0; i < animations.length; i++) {
				var anim : MovieClip = animations[i] as MovieClip;
				anim.visible = false;
				anim.stop();
			}
			animations[animInt].visible = true;
			if(playType == 0){
				animations[animInt].play();
			}else if (playType == 1) {
				playAnim(animations[animInt]);
			}
		}
		public function setDestination(xPos : int, yPos : int) :void {
			destination.x = xPos;
			destination.y = yPos;
		}
		
		public function calculateWaypoints(dest : Point):void 
		{
			var start : Point = new Point(Math.floor(x / TileSystem.globalTile.width), Math.floor(y / TileSystem.globalTile.height));
			var fin : Point = new Point(Math.floor(dest.x / TileSystem.globalTile.width), Math.floor(dest.y / TileSystem.globalTile.height));
			_waypointList = AStar.search(TileSystem.grid, start, fin);
		}
		
		override public function update():void 
		{
			super.update();
			setFocusOnTargetUnit();
			if (_waypointList.length > 0) {
				var curWaypoint : Point = new Point((_waypointList[0].position.x * TileSystem.globalTile.width),(_waypointList[0].position.y * TileSystem.globalTile.height));
				target.x = curWaypoint.x + TileSystem.globalTile.width / 2;
				target.y = curWaypoint.y + TileSystem.globalTile.height / 2;
				var tile : Tile = TileSystem.getTileFromPos(new Vector2D(target.x, target.y));
				if (TileSystem.getTileInt(target.x, target.y) != 2 && TileSystem.getTileInt(target.x, target.y) != 3 && TileSystem.getTileInt(target.x, target.y) != 6) {
					target.y -=  TileSystem.globalTile.height / 3;
				}
				
			}
			if(rangeView.seeAbleObjects.length != 0){
				if (targetUnit != null) {
					whenTargetInViewRange();
				}else {
					noTargetInViewRange();
				}
			}
			if (_moving){
				movement();
				_position.add(_velocity);
				
				x = _position.x;
				y = _position.y;
			}
		}
		protected function noTargetInViewRange():void 
		{
			if (_waypointList.length == 0) {
				if(destination.x - x > 1 || destination.y - y > 1){
					calculateWaypoints(destination);
				}else {
					if(animations[DEATH_ANIM].visible == false){
						goIdleState();
					}
				}
			}
			if (_moving == false && animations[WALK_ANIM].visible == true) {
				_moving = true;
			}	
		}
		protected function goIdleState() :void {
			if(deployUnit && animations[IDLE_ANIM].visible == false){
				_moving = false;
				switchAnim(IDLE_ANIM);
			}
		}
		protected function whenTargetInViewRange():void 
		{
			//action what to do when unit sees target.
		}
		override public function removeTarget(targetObj:GameObject):void 
		{
			super.removeTarget(targetObj);
			//_waypointList = [];
		}
		protected function setFocusOnTargetUnit():void 
		{
			if(targetUnit != targetObjects[0]){
				targetUnit = targetObjects[0]; //als er een target is dan stopt hij die er in anders is currentTarget null
			}
		}
		
		protected function movement():void 
		{
			if (!target)
			{
				return; 
			}
			
			var currentTarget : Vector2D = target.cloneVector();
			
			var desiredStep : Vector2D = currentTarget.subtract(_position);
			var distanceToTarget : Number =	desiredStep.length;
			
			desiredStep.normalize();
			
			var desiredVelocity:Vector2D = desiredStep.multiply(_speed);
			
			var steeringForce:Vector2D = desiredVelocity.subtract(_velocity);

			steeringForce.divide(2);
			
			_velocity.add(steeringForce);
			
			if (distanceToTarget <= _velocity.length * 1 && _moving) {
				closeToTarget();
			}
			if(_velocity.x < -1){
				turnArt(-1);
			}else if (velocity.x > 1) {
				turnArt(1)
			}
		}
		protected function turnArt(dir : int) :void {
			scaleX = dir;
		}
		public function takeDamage(dmg : int) :void {
			if(animations[DEATH_ANIM].visible == false){
				_health -= dmg;
				if (_health <= 0) {
					_health = 0;
					unitDeath();
				}
				hpBar.scaleBar(_health);
			}
		}
		
		protected function unitDeath():void 
		{
			_speed = 0;
			switchAnim(DEATH_ANIM, 1);
			if (this is EnemyUnit == false && this is BuildUnit == false) {
				var tile : Tile = TileSystem.getTileFromPos(new Vector2D(destination.x, destination.y));
				TileSystem.setTileInt(tile.x, tile.y, 2);
			}
			//trace("I'ma dead! Owa No"); // death animation etc etc. Maybe shout out death so tower can count kills.
		}
		
		override protected function AnimationFinishedPlaying():void 
		{
			super.AnimationFinishedPlaying();
			if (animations[DEATH_ANIM].visible == true) {
				removeObject();
			}
		}
		protected function closeToTarget():void 
		{
			_waypointList.splice(0, 1);
			if (_waypointList.length == 0) {
				lastWaypointReached();
			}
		}
		
		protected function lastWaypointReached():void 
		{	
			
		}
		override public function onCollisionEnter(other:GameObject):void 
		{
			if (other.checkTag(Tags.RANGE_COLLIDER_TAG) == false) {
				super.onCollisionEnter(other);
			}
		}
		override public function onInteraction():void 
		{
			super.onInteraction();
			var event : ShowInfoEvent = new ShowInfoEvent(InfoMenu.SHOW_INFO, ["Health : ", "Attack : ", "View : ", "Speed : "], [_health, attackDmg, viewDistance, _speed], true);
			dispatchEvent(event);
			rangeView.setAlpha(0.4);
		}
		override public function exitInteraction():void 
		{
			super.exitInteraction();
			dispatchEvent(new Event(InfoMenu.CLOSE_INFO, true));
			rangeView.setAlpha(0);
		}
		
		public function get velocity():Vector2D 
		{
			return _velocity;
		}
		
		public function get moving():Boolean 
		{
			return _moving;
		}
		override public function removeObject():void 
		{
			dispatchEvent(new Event(InfoMenu.CLOSE_INFO, true));
			super.removeObject();
		}
	}
}