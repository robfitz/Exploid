package com.exploid
{
	import com.exploid.events.EnemyEvent;
	import flash.events.Event;
	
	
	/**
	 * Game state that contains the emitters and special shit for a level 
	 * @author devin
	 * 
	 */	
	
	public class ExLevel
	{
		public var emmiter:ExEmitter;
		public var particles:ExGroup;
		public var player:ExPlayer;
		
		public function ExLevel()
		{
			particles = new ExGroup();
			particles.addEventListener(EnemyEvent.KILLED, onEnemyKilled);
		}
		
		private function onEnemyKilled(event:Event):void {
			ExGlobal.currentMultiplier ++;
		}
		
		public function createPlayer():void {
			player = new ExPlayer(100, 100);
			this.particles.add(player);
		}
		
		public function update():void {
			emmiter.update();
			particles.update();
		}
	}
}