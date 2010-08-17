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
		
		/**
		 * Update the group state and motion
		 */
		public function update():void {
			var member:ExParticle;
			for(var i:uint; i < members.length; i ++) {
				member = members[i] as ExParticle;
				member.update();
			} 
		}
	}
}