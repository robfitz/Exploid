package com.exploid
{
	/**
	 * Group series of game objects. 
	 * @author devin
	 * 
	 */	
	
	public class ExGroup
	{
		/**
		 * Members controlled and updated by this group 
		 */		
		public var members:Array;
		
		/**
		 * Default contructor 
		 * 
		 */		
		public function ExGroup()
		{
			members = new Array();
		}
		
		public function add(obj:ExParticle):void {
			this.members.push(obj);
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
		
		/**
		 * Update the group state and motion
		 */
		public function update():void {
			this.updateMotion();
			this.updateCollision();
		}
	}
}