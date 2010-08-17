package com.exploid
{
	import flash.ui.Keyboard;
	
	public class ExPlayer extends ExParticle
	{
		public function ExPlayer(x:Number=0, y:Number=0)
		{
			super(x, y);
			this.isSolid = true;
		}
		
		
		override public function update():void {
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
			
			super.update();
		}
	}
}