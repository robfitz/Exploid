package com.exploid.particles
{
	import com.exploid.ExParticle;
	import com.exploid.ExVector;

	/**
	 * This particle position is based solely off the location of another partcle. Useful for contructing
	 * complex large objects (like bosssssses?).
	 * 
	 * @author devin
	 * 
	 */	

	public class LinkedParticle extends EnemyParticle
	{
		public var parent:ExParticle;
		
		public function LinkedParticle(parent:ExParticle)
		{
			this.parent = parent;
		}
	}
}