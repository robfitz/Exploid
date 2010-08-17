package com.exploid.emitters
{
	import com.exploid.ExEmitter;
	import com.exploid.ExGlobal;
	import com.exploid.ExLevel;
	import com.exploid.ExParticle;
	
	public class EnemyEmitter extends ExEmitter
	{
		
		private static const EDGE_DIST:int = 10;
		
		private static const V_MIN:Number = 5;
		private static const V_MAX:Number = 30;
		
		public function EnemyEmitter(level:ExLevel, rate:Number = 1)
		{
			super(level, rate);
		}
		
		override protected function createParticle():ExParticle {
			//choose which edge this enemy will spawn from
			var dir:int = Math.random() * 3.99999;
			//choose how fast this enemy will move
			var v:Number = Math.random() * (V_MAX - V_MIN) + V_MIN;
			
			var x:int;
			var y:int;
			var angle:Number = Math.random() * (Math.PI) + Math.PI / 2; //from left edge 
			switch (dir) {
				case 0: //from top
					x = Math.random() * ExGlobal.worldWidth;
					y = -EDGE_DIST;
					angle -= Math.PI / 2;
					break;
				case 1: //from bottom
					x = Math.random() * ExGlobal.worldWidth;
					y = ExGlobal.worldHeight + EDGE_DIST;
					angle += Math.PI / 2;
					break;
				case 2: //from left
					x = -EDGE_DIST;
					y = Math.random() * ExGlobal.worldHeight;
					angle += Math.PI;
					break;
				case 3: //from right
					x = ExGlobal.worldWidth + EDGE_DIST;
					y = Math.random() * ExGlobal.worldHeight;
					angle += 0;
					break;
			}
		
			var vx:Number = v * Math.cos(angle);
			var vy:Number = v * Math.sin(angle);
		
			var enemy:ExParticle = new ExParticle(x, y);
			enemy.velocity.x = vx;
			enemy.velocity.y = vy;
		
			return enemy;
		}
	}
}