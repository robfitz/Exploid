package com.exploid.groups
{
	import com.exploid.ExGroup;
	import com.exploid.ExParticle;
	import com.exploid.events.EnemyEvent;
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
			this.updateParticle();
			this.updateCollision();
			this.updateStates();
		}
		
		private function updateParticle():void {
			var member:ExParticle; 
			for(var i:uint; i < members.length; i ++) {
				members[i].update();
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
						
						if(target.isSolid && target != subject) {
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
						
						this.dispatchEvent(new EnemyEvent(EnemyEvent.KILLED));

					} else {
						saved.push(subject);
					}
				}
			}
			this.members = saved;
		}

	}
}