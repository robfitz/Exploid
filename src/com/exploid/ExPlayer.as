package com.exploid
{
	import flash.ui.Keyboard;
	
	public class ExPlayer extends ExParticle
	{
		
		public static const ST_INVINCIBLE:String = "invincible";
		
		
		public static const MAX_INVINCIBLE_TIME:Number = 2;
		private var _invAge:Number;
		
		public var lives:uint;
		
		public function ExPlayer(x:Number=0, y:Number=0)
		{
			super(x, y);
			this.isSolid = true;
			this.state = ST_ALIVE;
			this.lives = ExGlobal.PLAYER_STARTING_LIVES;
		}
		
		override public function update():void {
			if(this.state == ExParticle.ST_ALIVE || this.state == ST_INVINCIBLE) {
				
				if(ExGlobal.input.isPressed(Keyboard.RIGHT)) {
					this.x += 5;
				}
				if(ExGlobal.input.isPressed(Keyboard.LEFT)) {
					this.x -= 5;
				}
				if(ExGlobal.input.isPressed(Keyboard.DOWN)) {
					this.y += 5;
				}
				if(ExGlobal.input.isPressed(Keyboard.UP)) {
					this.y -= 5;
				}
				
				if(ExGlobal.input.isPressed(Keyboard.SPACE)) {
					this.state = ExParticle.ST_EXPLODE;
				}
			}
			
			if(this.state == ST_INVINCIBLE) {
				_invAge += ExGlobal.elapsed;
				
				if(_invAge >= MAX_INVINCIBLE_TIME) {
					this.state = ExParticle.ST_ALIVE;
				}
			}
			
			super.update();
		}
		
		public override function set state(newState:String):void {
			var oldState:String = this.state;
			super.state = newState;
			
			switch(this.state) {
				case ExParticle.ST_ALIVE:
					break;
				case ExParticle.ST_DEAD:
					break;
				case ST_INVINCIBLE:
					_invAge = 0;
					break;
			}
		}
		
		/**
		 * Respawns the player if possible, and return true. 
		 * If the player cannot respawn (no lives left) returns false 
		 * @return True if player is respawned.
		 */		
		public function respawn():Boolean {
			if(this.lives <= 0) {
				return false;
			}
			lives --;
			_invAge = 0;
			state = ExPlayer.ST_INVINCIBLE;
			isSolid = true;
			return true;
		}
		
		/**
		 * Called when the player collides with any particle 
		 */		
		override protected function reportCollision(target:ExParticle):void {
			if(this.state == ExParticle.ST_ALIVE) {
				this.state = ExParticle.ST_DEAD;
				this.isSolid = false;
			}
		}
	}
}