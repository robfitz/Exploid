package com.exploid.particles
{
	public class OffsetParticle extends EnemyParticle
	{
		public function OffsetParticle(x:Number=0, y:Number=0)
		{
			super(x, y);
		}
		
		override public function update():void {
			if(this.parent && this.parent.state == ExParticle.ST_DEAD) {
				this.parent = null;
			}
			
			if(this.parent) {
				this.x = parent.x + offset.x;
				this.y = parent.y + offset.y;
				this.velocity = this.parent.velocity;
				this.acceleration = this.parent.acceleration;
			} else {
				// default to basic behavior if the parent is killed off
				super.update();
			}
		}
	}
}