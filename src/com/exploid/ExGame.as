package com.exploid
{
	import com.exploid.emitters.EnemyEmitter;
	import com.exploid.emitters.ExInput;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	
	/**
	 * Master controller for the Exploid game 
	 * @author devin
	 */	
	
	public class ExGame extends Sprite
	{
		
		private var _totalElapsed:uint = 0;
		
		public var level:ExLevel;
		
		public function ExGame()
		{
			this.init();
		}
		
		public function update(event:Event):void {
			
			// calculate (and limit?) our frame time
			var mark:uint = flash.utils.getTimer();
			var tick:uint = mark - _totalElapsed;
			var tickSec:Number = tick / 1000;
			ExGlobal.elapsed = tickSec;
			_totalElapsed = mark;
		
			// TODO: update the sound objects
			
			// TODO: update the HUD	
		
			// update the game objects
			ExGlobal.input.updateInput();
			level.update();
		}
		
		
		/**
		 * Called to setup the guts for our game once 
		 */		
		public function init():void {
			
			// default groups
			this.level = new ExLevel();
			this.level.emmiter = new EnemyEmitter(this.level, .1);
			
			// get everything humming
			_totalElapsed = flash.utils.getTimer();
			this.addEventListener(Event.ENTER_FRAME, update);
		}
	}
}