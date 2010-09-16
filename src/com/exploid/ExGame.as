package com.exploid
{
	import com.exploid.emitters.BossEmitter;
	import com.exploid.emitters.EnemyEmitter;
	import com.exploid.enemies.BossExample;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;
	
	
	/**
	 * Master controller for the Exploid game 
	 * @author devin
	 */	
	
	public class ExGame extends Sprite
	{
		
		private var _totalElapsed:uint = 0;
		
		private var _level:ExLevel;
		public function get level():ExLevel { return _level; }
		public function set level(newlevel:ExLevel):void {
			_level = newlevel;
			ExGlobal.currentLevel = newlevel;
		}
		
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
			
			//update the input
			ExGlobal.input.updateInput();
		
			// TODO: update the sound objects
			
			// TODO: update the HUD	
		
			// update the game objects
			level.update();
		}
		
		
		/**
		 * Called to setup the guts for our game once 
		 */		
		public function init():void {
			
			// default groups
			this.level = new ExLevel();
			
			this.level.particles.add(new EnemyEmitter(this.level, 1));
//			var boss:BossEmitter = new BossEmitter(this.level, new BossExample());
//			this.level.particles.add(boss);
//			boss.emit();
			
			// init the input we'll be using
			ExGlobal.input.addKey(Keyboard.SPACE);
			ExGlobal.input.addKey(Keyboard.LEFT);
			ExGlobal.input.addKey(Keyboard.RIGHT);
			ExGlobal.input.addKey(Keyboard.UP);
			ExGlobal.input.addKey(Keyboard.DOWN);
		
			// get everything humming
			_totalElapsed = flash.utils.getTimer();
			this.addEventListener(Event.ENTER_FRAME, update);
		}
	}
}