package com.exploid
{
	/**
	 * Superclass for all the particles and shit flying around the screen during a game. 
	 * @author devin
	 * 
	 */	
	
	public class ExParticle extends ExVector
	{
		
		public var velocity:ExVector;
		
		public var acceleration:ExVector;
		
		public var maxVelocity:ExVector;
		
		public var isSolid:Boolean;
		
		public var radius:Number;
		
		public function ExParticle(x:Number = 0, y:Number = 0)
		{
			super(x, y);
			
			this.velocity = new ExVector();
			this.acceleration = new ExVector();
			this.maxVelocity = new ExVector(1000, 1000);
			this.isSolid = false;
			this.radius = 10;
		}
		
		/**
		 * Update the objects position and state
		 */
		public function update():void {
			
			velocity.x += acceleration.x * ExGlobal.elapsed;
			velocity.y += acceleration.y * ExGlobal.elapsed;
			
			x += velocity.x * ExGlobal.elapsed;
			y += velocity.y * ExGlobal.elapsed;
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
				this.reportCollision();
			}
		}
		
		public function reportCollision():void {
			trace("Basic collision found");
		}
		
	}
}