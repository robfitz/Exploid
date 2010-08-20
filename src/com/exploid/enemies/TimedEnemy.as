package com.exploid.enemies
{
	import com.exploid.ExParticle;

	public class TimedEnemy extends EnemyParticle
	{
		public static const ST_COUNT_DOWN:String = "countingdown";
		
		public function TimedEnemy(fusetime:Number = 2, x:Number=0, y:Number=0)
		{
			super(x, y);
			this.lifetime = fusetime;
		}
		
		override public function set state(newstate:String):void {
			var oldState:String = this.state;
			super.state = newstate;
			
			switch(this.state) {
				case ST_COUNT_DOWN:
					this.canAge = true; 
					break; 
			}
		}
		
		/**
		 * Override the explosion state to start a countdown rather then 
		 * instantly start exploding
		 */		
		override public function explode():void {
			this.state = ST_COUNT_DOWN;
		}
		
		/**
		 * Coundown complete, let's eplode
		 */
		override protected function aged():void {
			this.state = ST_EXPLODE;
		}
	}
}