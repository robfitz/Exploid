package com.exploid.events
{
	import flash.events.Event;

	public class EnemyEvent extends Event
	{
		public static const KILLED:String = "EnemyEvent_Killed";
		
		public function EnemyEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}