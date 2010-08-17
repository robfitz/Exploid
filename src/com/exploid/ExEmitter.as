package com.exploid
{
	public class ExEmitter
	{
		/**
		 * The level we'll emit our particles into
		 */		
		public var level:ExLevel;
		
		/**
		 * Rate of emission in particles per seconds
		 */		
		public var secPerParticle:Number;
		
		/**
		 * How much time has elapsed since we pooped out a particle 
		 */		
		public var secSinceLast:Number;
		
		public function ExEmitter(level:ExLevel, rate:Number = 1)
		{
			this.level = level;
			this.secPerParticle = rate;
			this.secSinceLast = 0;
		}
		
		public function update():void {
			this.secSinceLast += ExGlobal.elapsed;
			
			while(secSinceLast >= secPerParticle) {
				emit();
				secSinceLast -= this.secPerParticle;
			}
		}
		
		public final function emit():void {
			this.level.particles.add(this.createParticle());
		}
		
		protected function createParticle():ExParticle {
			var bob:ExParticle = new ExParticle(600, 100);
			bob.velocity.x = -10;
			return bob;
		}
	}
}