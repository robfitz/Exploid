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
			player = new ExPlayer(ExGlobal.worldWidth / 2, ExGlobal.worldHeight / 2);
			player.state = ExPlayer.ST_INVINCIBLE;
			this.particles.add(player);
		}
		
		public function update():void {
			emmiter.update();
			particles.update();
			
			// check if respawn is needed / possible
			if(player.state == ExParticle.ST_DEAD && this.player.respawn()) {
				player.x = ExGlobal.worldWidth / 2;
				player.y = ExGlobal.worldHeight / 2;
				this.particles.add(player);
			}
		}
	}
}