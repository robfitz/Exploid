package com.exploid.emitters
{
	import com.exploid.ExEmitter;
	import com.exploid.ExGlobal;
	import com.exploid.ExLevel;
	import com.exploid.particles.NormalEnemy;
	
	public class EnemyEmitter extends ExEmitter
	{
		
		private static const EDGE_DIST:int = -30;
		
		private static const V_MIN:Number = 5;
		private static const V_MAX:Number = 30;
		
		public function EnemyEmitter(level:ExLevel, rate:Number = 1)
		{
			super(level, rate);
		}
		
		override protected function createParticles():Array {
			//choose which edge this enemy will spawn from
			var dir:int = Math.random() * 3.99999;
			//choose how fast this enemy will move
			var v:Number = Math.random() * (V_MAX - V_MIN) + V_MIN;
			
			var x:int;
			var y:int;
			var angle:Number = Math.random() * (Math.PI); //from facing south
			switch (dir) {
				case 0: //from top
					x = Math.random() * ExGlobal.worldWidth;
					y = -EDGE_DIST;
					angle -= 0;
					break;
				case 1: //from bottom
					x = Math.random() * ExGlobal.worldWidth;
					y = ExGlobal.worldHeight + EDGE_DIST;
					angle += Math.PI;
					break;
				case 2: //from left
					x = -EDGE_DIST;
					y = Math.random() * ExGlobal.worldHeight;
					angle -= Math.PI / 2;
					break;
				case 3: //from right
					x = ExGlobal.worldWidth + EDGE_DIST;
					y = Math.random() * ExGlobal.worldHeight;
					angle += Math.PI / 2;
					break;
			}
		
			var enemy:Array = createEnemyParticles();
			rotate(enemy, angle);
			
			var vx:Number = v * Math.cos(angle);
			var vy:Number = v * Math.sin(angle);
			
			for each (var p:NormalEnemy in enemy) {
				p.x += x;
				p.y += y;
				p.velocity.x = vx;
				p.velocity.y = vy;
			}		
		
			return enemy;
		}
		
		private function rotate(particles:Array, angle:Number):void {
			angle += Math.PI / 2;
			
			for each (var p:NormalEnemy in particles) {
				//rotate around 0,0
				var len:Number = Math.sqrt(p.x*p.x + p.y*p.y);
				var old_angle:Number = Math.atan2(p.y, p.x);
				var new_angle:Number = old_angle + angle;
				var new_x:Number = len * Math.cos(new_angle);
				var new_y:Number = len * Math.sin(new_angle);
				p.x = new_x;
				p.y = new_y;
			}
		}
		
		
		private function createEnemyParticles():Array {
			var particles:Array = [];
			var SPACING:int = 16;
			
			var rand:Number = Math.random();
			if (rand < .6) { 
				//lonely dot
				particles = [new NormalEnemy(0, 0)];
			}
			else if (rand < .8) {
				//cross	
				particles = [new NormalEnemy(0, 0), //center
							new NormalEnemy(-SPACING, 0), //left
							new NormalEnemy(SPACING, 0), //right
							new NormalEnemy(0, -SPACING), //top
							new NormalEnemy(0, SPACING)]; //bottom
							
			}
			else if (rand < .9) {
				//3-piece triangle
				particles = [new NormalEnemy(0, 0), //center
							new NormalEnemy(-SPACING, SPACING), //down left
							new NormalEnemy(SPACING, SPACING)]; //down right
			}
			else if (rand < 1) {
				//flying V
				particles = [new NormalEnemy(0, 0), //center
							new NormalEnemy(-SPACING, SPACING), //down left
							new NormalEnemy(SPACING, SPACING), //down right 
							new NormalEnemy(-SPACING * 2, SPACING * 2), //down left x 2
							new NormalEnemy(SPACING * 2, SPACING * 2)]; //down right x 2
			}
			
			return particles;
		}
	}
}