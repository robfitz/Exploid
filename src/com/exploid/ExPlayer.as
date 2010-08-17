package com.exploid
{
	import flash.ui.Keyboard;
	
	public class ExPlayer extends ExParticle
	{
		
		public static const ST_ALIVE:String = "alive";
		
		public function ExPlayer(x:Number=0, y:Number=0)
		{
			super(x, y);
			this.isSolid = true;
			this.state = ST_ALIVE;
		}
		
		
		
		override public function update():void {
			if(this.state == ST_ALIVE) {
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
			}
			
			super.update();
		}
		
		public override function set state(newState:String):void {
			var oldState:String = this.state;
			super.state = newState;
			
			switch(this.state) {
				case ST_ALIVE:
					break;
				case ExParticle.ST_DEAD:
					break;
			}
		}
		
		/**
		 * Called when the player collides with any particle 
		 */		
		override protected function reportCollision():void {
			this.state = ExParticle.ST_DEAD;
			this.isSolid = false;
		}
	}
}