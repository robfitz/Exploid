package com.exploid.enemies
{
	import com.exploid.ExGlobal;
	import com.exploid.ExParticleTemplate;
	import com.exploid.emitters.DirectionalEmitter;
	import com.exploid.particles.OrbitingParticle;

	public class BossExample extends ExParticleTemplate
	{
		public function BossExample()
		{
			super();
		}
		
		override public function createParticles():Array {
			var bp:Array = [];
			
			// the central node
			var node:DirectionalEmitter = new DirectionalEmitter(ExGlobal.currentLevel, 1, 0, 50);
			node.particleType = TimedEnemy;
			node.emitAngleWiggle = .1;
			node.secPerParticle = .8;
			node.velocity.x = 15;
			node.x = 0;
			node.y = 200;
			bp.push(node);
			
			// some dudes around him in a circle
			var rad:Number = 0; 
			do {
				var link:OrbitingParticle = new OrbitingParticle(node);
				link.orbitRadius = 100;
				link.orbitTheta = rad;
				link.orbitVelocity = Math.PI / 6;
				
				rad += Math.PI / 10;
				bp.push(link);
			} while(rad < Math.PI * 2);
			
			rad = 0; 
			do {
				link = new OrbitingParticle(node);
				link.orbitRadius = 140;
				link.orbitTheta = rad;
				link.orbitVelocity = - Math.PI / 10;
				
				rad += Math.PI / 10;
				bp.push(link);
			} while(rad < Math.PI * 2);
			
			return bp;
		}
		
	}
}