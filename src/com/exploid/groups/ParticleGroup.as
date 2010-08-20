package com.exploid.groups
{
	import com.exploid.ExGlobal;
	import com.exploid.ExGroup;
	import com.exploid.ExParticle;
	import com.exploid.hud.GameTextManager;
	import com.exploid.particles.Explosion;
	
	public class ParticleGroup extends ExGroup
	{
		public function ParticleGroup()
		{
			super();
		}
		
		/**
		 * Update the group state and motion
		 */
		override public function update():void {
			this.updateMotion();
			this.updateCollision();
			this.updateStates();
		}
		
		private function updateMotion():void {
			var member:ExParticle; 
			for(var i:uint; i < members.length; i ++) {
				member = members[i] as ExParticle;
				member.update();
			}
		}
		
		private function updateCollision():void {
			var subject:ExParticle;
			var target:ExParticle;
			
			for(var i:uint = 0; i < this.members.length; i ++) {
				subject = this.members[i] as ExParticle;
				
				if(subject.isSolid) {
					// this particle can hit with anything
					for(var j:uint = 0; j < this.members.length; j ++) {
						target = this.members[j] as ExParticle;
						
						if(target != subject) {
							subject.collideWith(target);
						}
					}
				}
			}
		}
		
		private function updateStates():void {
			var subject:ExParticle;
			var saved:Array = [];
			
			for(var i:uint = 0; i < this.members.length; i ++) {
				subject = this.members[i] as ExParticle;
				
				if(subject.state != ExParticle.ST_DEAD) {
					
					if (subject.state == ExParticle.ST_EXPLODE) {
						// need to cull this guy out and replace him with an explosion!
						subject.state = ExParticle.ST_DEAD;
						var ex:Explosion = Explosion.explosionFromParticle(subject);
						saved.push(ex);
						
						var score:uint = ExGlobal.kill();
						GameTextManager.instance.show(score.toString(), subject.x, subject.y);

					} else {
						saved.push(subject);
					}
				}
			}
			this.members = saved;
		}

	}
}