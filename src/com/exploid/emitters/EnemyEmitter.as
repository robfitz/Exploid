package com.exploid.emitters
{
	import com.exploid.ExEmitter;
	import com.exploid.ExGlobal;
	import com.exploid.ExLevel;
	import com.exploid.ExParticle;
	
	public class EnemyEmitter extends ExEmitter
	{
		public function EnemyEmitter(level:ExLevel, rate:Number = 1)
		{
			super(level, rate);
		}
		
		override protected function createParticle():ExParticle {
			
			var enemy:ExParticle = new ExParticle(Math.random() * ExGlobal.worldWidth, Math.random() * ExGlobal.worldHeight);
			enemy.velocity.x = -20; 
			
			return enemy;
		}
	}
}