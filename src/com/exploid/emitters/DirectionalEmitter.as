package com.exploid.emitters
{
	import com.exploid.ExEmitter;
	import com.exploid.ExLevel;
	import com.exploid.ExParticle;

	public class DirectionalEmitter extends ExEmitter
	{
		/**
		 * Direction of the emit 
		 */		
		public var emitAngle:Number;
		
		/**
		 * Amount of wiggle to add to the direction
		 */
		public var emitAngleWiggle:Number;
		
		/**
		 * Initial velocity of particles emitted 
		 */		
		public var emitVelocity:Number;
		
		/**
		 * Amount of wiggle to add to the velocity 
		 */
		public var emitVelocityWiggle:Number; 
		
		public function DirectionalEmitter(level:ExLevel, rate:Number = 1, emitAngle:Number = 0, emitVelocity:Number = 0)
		{
			super(level, rate);
			this.emitAngle = emitAngle;
			this.emitVelocity = emitVelocity;
			this.emitAngleWiggle = 0;
			this.emitVelocityWiggle = 0;
			this.canExplode = true;
		}
		
		override protected function createParticles():Array {
			var p:ExParticle = new particleType();
			var pt:Number = this.emitAngle + ((Math.random() - .5) * this.emitAngleWiggle);
			var pv:Number = this.emitVelocity + ((Math.random() - .5) * this.emitVelocityWiggle);
			p.velocity.x = pv * Math.cos(pt);
			p.velocity.y = pv * Math.sin(pt);
			p.x = this.x;
			p.y = this.y;
			return [p];
		}
	}
}