package com.exploid.emitters
{
	import com.exploid.ExEmitter;
	import com.exploid.ExGlobal;
	import com.exploid.ExLevel;
	import com.exploid.enemies.EnemyParticle;
	
	import flash.geom.Point;
	
	public class EnemyEmitter extends ExEmitter
	{
		/** the shape of enemy formations. must be initialized in 
		 * constructor if currently null */
		private static var STANDARD_FORMATIONS:Array;
		
		/** how likely a given formation is to spawn, of format
		 * [x, y, z, ..., 1.0] where 0 < x < y < z < ... < 1.0 */
		private static var DEFAULT_FREQUENCIES:Array;
		
		/** how far beyond the playfield edge the enemies should spawn
		 * before travelling inward. set to a negative number to see the
		 * spawns on-screen for debugging, or a positive number for 
		 * the proper player experience */
		private static const EDGE_DIST:int = 60;
		/** distance between each particle of an enemy ship */
		private static const PARTICLE_SPACING:int = 32;
		
		/** minimum velocity of an enemy */
		private static const V_MIN:Number = 15;
		/** maximum velocity of an enemy */
		private static const V_MAX:Number = 45;
		
		
		private var enemyFormations:Array;
		/** how likely a given formation is to spawn, of format
		 * [x, y, z, ..., 1.0] where 0 < x < y < z < ... < 1.0 */
		private var formationFrequencies:Array;
		/** factor applied to new enemy velocities to allow for scaling
		 * difficult in addition to the variance between enemies at the same stage */
		private var velocityModifier:Number;
		
		public function EnemyEmitter(level:ExLevel, secPerParticle:Number=1, formationFrequencies:Array=null, velocityModifier:Number=1)
		{
			super(level, secPerParticle);
			if (!STANDARD_FORMATIONS) initStandardFormations();
			this.isSolid = false;
			
			this.velocityModifier = velocityModifier;
			if (formationFrequencies) this.formationFrequencies = formationFrequencies;
			else this.formationFrequencies = DEFAULT_FREQUENCIES;
			
			this.enemyFormations = STANDARD_FORMATIONS;
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
			
			for each (var p:EnemyParticle in enemy) {
				p.x += x;
				p.y += y;
				p.velocity.x = vx;
				p.velocity.y = vy;
			}		
		
			return enemy;
		}
		
		private function rotate(particles:Array, angle:Number):void {
			angle += Math.PI / 2;
			
			for each (var p:EnemyParticle in particles) {
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
			//pick which formation we'll create, based on the frequency distribution set early
			var rand:Number = Math.random();
			for (var i:int = 0; i < formationFrequencies.length && i < enemyFormations.length; i ++) {
				if (rand < formationFrequencies[i]) {
					break;					
				}
			}
			//create the particles based on the formation layout
			var formation:Array = enemyFormations[i];
			var particles:Array = [];
			for each (var p:Point in formation) {
				particles.push(new EnemyParticle(p.x * PARTICLE_SPACING, p.y * PARTICLE_SPACING));
			}
			
			return particles;
		}
		
		private function initStandardFormations():void {
			//how often each of the standard formations spawns
			DEFAULT_FREQUENCIES = [.6, .8, .9, 1];
			
			//basic single point
			STANDARD_FORMATIONS = [[new Point(0, 0)]];
			
			//cross
			STANDARD_FORMATIONS.push([new Point(0, 0),//center
							new Point(-1, 0), //left
							new Point(1, 0), //right
							new Point(0, -1), //top
							new Point(0, 1)]); //bottom
					
			//triangle		
			STANDARD_FORMATIONS.push([new Point(0, 0), //center
							new Point(-1, 1), //down left
							new Point(1, 1)]); //down right
			
			//5-piece flying V
			STANDARD_FORMATIONS.push([new Point(0, 0), //center
							new Point(-1, 1), //down left
							new Point(1, 1), //down right 
							new Point(-1 * 2, 1 * 2), //down left x 2
							new Point(1 * 2, 1 * 2)]); //down right x 2
		}
	}
}