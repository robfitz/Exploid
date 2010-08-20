package com.exploid
{
	
	import com.exploid.enemies.TimedEnemy;
	
	import flash.display.Graphics;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	public class ExGlobal
	{
		///////////////////////////////////////////////////
		// Game Constants and Variable
		///////////////////////////////////////////////////
		public static var elapsed:Number;
		
		public static var worldWidth:int = 800;
		
		public static var worldHeight:int = 400;
		
		public static var input:ExInput;
		
		public static const PLAYER_STARTING_LIVES:uint = 3;
		
		///////////////////////////////////////////////////
		// Scoring
		///////////////////////////////////////////////////
		[Bindable] public static var score:int  = 0;
		
		public static function kill(basePoints:uint=800):uint {
			currentMultiplier ++;
			var delta:uint = basePoints * currentMultiplier;
			currentChainScore += delta;
			return delta;
		}
		
		
		public static var currentChainScore:uint = 0;
		
		public static function get currentMultiplier():int { return _currentMultiplier; }
		public static function set currentMultiplier(value:int):void { 
			_currentMultiplier = value;
			//if a chain happened quickly enough, reset the combo trigger
			flash.utils.clearTimeout(_multiplierTimeout);
			_multiplierTimeout = flash.utils.setTimeout(clearMultiplier, COMBO_TIME * 1000);
		}
		private static var _currentMultiplier:int = 0;
		public static const COMBO_TIME:Number = 1;
		private static var _multiplierTimeout:uint;
		
		private static function clearMultiplier():void {
			//add score from current combo onto the main scoreboard
			score += currentChainScore;
			//reset chain
			_currentMultiplier = 0;
			currentChainScore = 0;
		}
		
		///////////////////////////////////////////////////
		// Debug Functionality
		///////////////////////////////////////////////////
		/**
		 * Draws information about the current state on a ExGroup
		 * directly onto the graphics buffer. 
		 *  
		 * @param g The graphics context to draw onto
		 * @param group The group to draw
		 * @param lineColor The colors to use (default black)
		 */		
		public static function debugDraw(g:Graphics, group:ExGroup, lineColor:uint = 0x0):void {
			
			g.lineStyle(1, lineColor);
			
			for each(var obj:ExParticle in group.members) {
				g.drawCircle(obj.x, obj.y, obj.radius);
				g.moveTo(obj.x, obj.y);
				g.lineTo(obj.x + obj.velocity.x, obj.y + obj.velocity.y);
				
				if(obj is ExPlayer) {
					g.drawCircle(obj.x, obj.y, obj.radius / 2);
				}
				
				if(obj is TimedEnemy) {
					var t:TimedEnemy = obj as TimedEnemy;
					g.lineStyle(1, lineColor, .5);
					
					if(t.state == TimedEnemy.ST_COUNT_DOWN) {
						var a:Number = 0;
						
						g.moveTo(obj.x + obj.radius * Math.cos(a), obj.y + obj.radius * Math.sin(a));
						while(a < (t.lifetime - t.age) / t.lifetime * 2 * Math.PI ){
							a += .1
							g.lineTo(obj.x + obj.radius / 2 * Math.cos(a), obj.y + obj.radius / 2 * Math.sin(a));
						}
					} else {
						g.drawCircle(obj.x, obj.y, obj.radius / 2);
					}
					
					g.lineStyle(1, lineColor);
				}
			}
		}
	}
}