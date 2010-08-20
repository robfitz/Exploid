package com.exploid
{
	import com.exploid.enemies.EnemyParticle;
	
	public class ExEmitter extends ExParticle implements IExUpdate
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
		
		/**
		 * Are we actively emitting particles?  
		 */		
		public var isEmitting:Boolean;
		
		/**
		 * Type of particle class to create on emit 
		 */		
		public var particleType:Class = com.exploid.enemies.EnemyParticle;
		
		public function ExEmitter(level:ExLevel, rate:Number = 1)
		{
			super();
			this.isSolid = false;
			this.canAge = false;
			this.level = level;
			this.secPerParticle = rate;
			this.secSinceLast = 0;
			this.isEmitting = true;
		}
		
		override public function update():void {
			super.update(); 
			
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
			return [new particleType()];
		}
	}
}