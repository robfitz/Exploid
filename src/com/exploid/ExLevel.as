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
			player = new ExPlayer(ExGlobal.worldWidth / 2, ExGlobal.worldHeight / 2);
			player.state = ExPlayer.ST_INVINCIBLE;
			this.particles.add(player);
		}
		
		public function update():void {
			var needsRespawn:Boolean = false;
			if(player.state == ExParticle.ST_DEAD) {
				needsRespawn = true;
			}
			
			emmiter.update();
			particles.update();
			
			if(needsRespawn) {
				// old player, since it's dead, will be culled in the particle update
				this.createPlayer();
			}
		}
	}
}