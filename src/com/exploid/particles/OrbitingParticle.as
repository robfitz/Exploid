package com.exploid.particles
{
	import com.exploid.ExGlobal;
	import com.exploid.ExParticle;

	public class OrbitingParticle extends LinkedParticle
	{
		
		public var orbitRadius:Number;
		
		public var orbitTheta:Number;
		
		public var orbitVelocity:Number;
		
		public function OrbitingParticle(parent:ExParticle)
		{
			super(parent);
			orbitRadius = 100;
			orbitTheta = 0
			orbitVelocity = Math.PI / 2;
		}
		
		override public function update():void {
			if(this.parent && this.parent.state == ExParticle.ST_DEAD) {
				this.parent = null;
			}
			
			if(this.parent) {
				this.orbitTheta += this.orbitVelocity * ExGlobal.elapsed;
				this.x = parent.x + orbitRadius * Math.cos(this.orbitTheta);
				this.y = parent.y + orbitRadius * Math.sin(this.orbitTheta);
				
				this.velocity = this.parent.velocity;
				this.acceleration = this.parent.acceleration;
			} else {
				// default to basic behavior if the parent is killed off
				super.update();
			}
		}
	}
}