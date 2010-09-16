package com.exploid.enemies
{
	import com.exploid.ExParticle;

	public class EnemyParticle extends ExParticle
	{
		
		public function EnemyParticle(x:Number=0, y:Number=0)
		{
			super(x, y);
			this.isSolid = false;
			this.canExplode = true;
			this.state = ExParticle.ST_ALIVE;
			this.radius = 20;
		}
	}
}