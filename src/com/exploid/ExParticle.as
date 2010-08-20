package com.exploid
{
	/**
	 * Superclass for all the particles and shit flying around the screen during a game. 
	 * @author devin
	 * 
	 */	
	
	public class ExParticle extends ExVector implements IExUpdate
	{
		
		public static const ST_NONE:String = "none";
		public static const ST_DEAD:String = "dead";
		public static const ST_EXPLODE:String = "start exploding";
		public static const ST_ALIVE:String = "alive";
		
		public var velocity:ExVector;
		
		public var acceleration:ExVector; 
		
		public var maxVelocity:ExVector;
		
		public var isSolid:Boolean;
		
		public var canExplode:Boolean;
		
		public var radius:Number;
		
		private var _state:String;
		
		public var lifetime:Number;
		
		public var age:Number; 
		
		public var canAge:Boolean;
		
		public function ExParticle(x:Number = 0, y:Number = 0)
		{
			super(x, y);
			
			this.velocity = new ExVector();
			this.acceleration = new ExVector();
			this.maxVelocity = new ExVector(1000, 1000);
			this.isSolid = false;
			this.canExplode = false;
			this.radius = 10;
			this.state = ST_ALIVE;
			this.lifetime = 0;
			this.age = 0;
			this.canAge = false;
		}
		
		/**
		 * Update the objects position and state
		 */
		public function update():void {
			if(this.canAge) {
				this.age += ExGlobal.elapsed;
				if(this.age >= this.lifetime) {
					this.aged();
				}
			}
			
			velocity.x += acceleration.x * ExGlobal.elapsed;
			velocity.y += acceleration.y * ExGlobal.elapsed;
			
			x += velocity.x * ExGlobal.elapsed;
			y += velocity.y * ExGlobal.elapsed;
		}
		
		public function get state():String { return _state; }
		public function set state(newState:String):void {
			var oldState:String = _state;
			_state = newState;
		}
		
		/**
		 * Called when a particle has reached it's max age 
		 */		
		protected function aged():void {
			this.state = ST_DEAD;
		}
		
		/**
		 * Signals that this particle has been hit by an explosion. 
		 * Usually only called by another explosion entity
		 */
		public function explode():void {
			this.state = ST_EXPLODE;
		}
		
		
		/**
		 * Checks if a collision has occured 
		 * @param target The particle we're insepcting 
		 */		
		public function collideWith(target:ExParticle):void {
			var dx:Number = this.x - target.x;
			var dy:Number = this.y - target.y;
			var radii:Number = this.radius + target.radius;
			
			if(dx * dx + dy * dy - radii * radii <= 0) {
				this.reportCollision(target);
			}
		}
		
		protected function reportCollision(target:ExParticle):void {
			
		}
		
	}
}