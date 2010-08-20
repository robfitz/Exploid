package com.exploid
{
	import flash.events.EventDispatcher;
	
	/**
	 * Group series of game objects. 
	 * @author devin
	 * @dispatches EnemyEvent.KILLED
	 */	
	
	public class ExGroup implements IExUpdate
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
		
		public function add(obj:IExUpdate):void {
			this.members.push(obj);
		}
		
		/**
		 * Update the group state and motion
		 */
		public function update():void {
			for(var i:uint = 0; i < members.length; i ++) {
				members[i].update();
			}
		}
	}
}