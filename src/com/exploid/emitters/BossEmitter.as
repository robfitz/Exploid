package com.exploid.emitters
{
	import com.exploid.ExEmitter;
	import com.exploid.ExLevel;
	import com.exploid.ExParticleTemplate;
	
	/**
	 * Creates an single instance of a boss / complex particle arrangement and emits it to the world.
	 * These are defined by particle template classes. 
	 * 
	 * By deafault, emit must be called directly, as we'll ignore update message. Automatic emitting can
	 * be turned back on, if wanted.
	 *  
	 * @author devin
	 * 
	 */	

	public class BossEmitter extends ExEmitter
	{
		public var template:ExParticleTemplate;
		
		public function BossEmitter(level:ExLevel, template:ExParticleTemplate)
		{
			super(level, 0);
			this.template = template;
			this.isEmitting = false;
		}
		
		override protected function createParticles():Array {
			return this.template.createParticles();
		}
	}
}