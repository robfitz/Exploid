package com.exploid
{
	public class ExEmitter extends ExVector implements IExUpdate
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
		
		public var isEmitting:Boolean;
		
		public function ExEmitter(level:ExLevel, rate:Number = 1)
		{
			this.level = level;
			this.secPerParticle = rate;
			this.secSinceLast = 0;
			this.isEmitting = true;
		}
		
		public function update():void {
			if(this.isEmitting) {
				this.secSinceLast += ExGlobal.elapsed;
				
				while(secSinceLast >= secPerParticle) {
					emit();
					secSinceLast -= this.secPerParticle;
				}
			}
		}
		
		public final function emit():void {
			for each (var p:ExParticle in this.createParticles()) {
				this.level.particles.add(p);
			}
		}
		
		protected function createParticles():Array {
			var bob:ExParticle = new ExParticle(600, 100);
			bob.velocity.x = -10;
			return [bob];
		}
	}
}