package com.exploid.particles
{
	import com.exploid.ExGlobal;
	import com.exploid.ExParticle;

	public class Explosion extends ExParticle
	{
		
		public static const ST_EXPLODING:String = "exploding";
		
		public static function explosionFromParticle(particle:ExParticle):Explosion {
			var ex:Explosion = new Explosion(particle.x, particle.y);
			
			ex.state = ST_EXPLODING;
			ex.canAge = true;
			ex.lifetime = .5;
			ex.radius = 1;
			ex.isSolid = true;
			
			return ex;
		}
		
		public var expandPerSec:Number = 100;
		
		public function Explosion(x:Number=0, y:Number=0)
		{
			super(x, y);
		}
		
		override public function update():void {
			super.update();
			this.radius += this.expandPerSec * ExGlobal.elapsed;
		}
		
		override protected function reportCollision(target:ExParticle):void {
			if(target.state == ExParticle.ST_ALIVE && target.canExplode) {
				target.explode();
			}
		}
	}
}