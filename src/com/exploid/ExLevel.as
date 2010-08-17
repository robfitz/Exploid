package com.exploid
{
	
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