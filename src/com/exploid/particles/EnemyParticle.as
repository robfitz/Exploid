package com.exploid.particles
{
	import com.exploid.ExParticle;

	public class EnemyParticle extends ExParticle
	{
		
		public function EnemyParticle(x:Number=0, y:Number=0)
		{
			super(x, y);
			this.state = ExParticle.ST_ALIVE;
		}
	}
}